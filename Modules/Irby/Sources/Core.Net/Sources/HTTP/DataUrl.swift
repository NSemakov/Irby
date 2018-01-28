// ----------------------------------------------------------------------------
//
//  DataUrl.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import Gzip
import NetworkingApiHttp
import NetworkingApiRest
import SwiftCommonsLang

// ----------------------------------------------------------------------------

open class DataUrl
{
// MARK: - Construction

    public init?(url: URL) throws
    {
        guard (url.scheme == Inner.DataScheme) else {
            return nil
        }

        let string = String(url.absoluteString[(Inner.DataScheme + ":").endIndex...])

        let isBase64 = string.contains(Inner.Base64Separator)
        let separator = isBase64 ? (Inner.Base64Separator + Inner.DataPrefix) : Inner.DataPrefix

        let components = string.components(separatedBy: separator)
        guard (components.count == 2) else {
            throw DataUrlError.FormatError(cause: nil)
        }

        self.mediaType = try DataUrl.parse(mediaTypeComponent: components[0])
        self.data = try DataUrl.parse(dataComponent: components[1], mediaType: self.mediaType, isBase64: isBase64)
    }

// MARK: - Properties

    public let mediaType: MediaType

    public let data: Data

// MARK: - Private Methods

    private static func parse(mediaTypeComponent: String) throws -> MediaType
    {
        var error: NSError?
        guard let mediaType = MediaType.parseMediaType(mediaTypeComponent, error: &error) else {
            throw DataUrlError.MediaTypeError(cause: error)
        }

        return mediaType
    }

    private static func parse(dataComponent: String, mediaType: MediaType, isBase64: Bool) throws -> Data
    {
        let result: Data

        if isBase64
        {
            guard let data = Data(base64Encoded: dataComponent) else {
                throw DataUrlError.FormatError(cause: nil)
            }

            if let e = mediaType.parameter(name: Inner.ContentEncodingParamName)
            {
                guard let encoding = ContentEncoding(rawValue: e) else {
                    throw DataUrlError.UnknownContentEncoding(cause: nil)
                }

                do {
                    result = try decode(data: data, encoding: encoding)
                }
                catch(let error) {
                    throw DataUrlError.DataError(cause: error)
                }
            }
            else {
                result = data
            }
        }
        else
        {
            guard let stringData = dataComponent.data(using: .utf8) else {
                throw DataUrlError.DataError(cause: nil)
            }

            result = stringData
        }

        return result
    }

    private static func decode(data: Data, encoding: ContentEncoding) throws -> Data
    {
        let result: Data

        switch encoding
        {
            case .Gzip:
                result = try data.gunzipped()

            case .Deflate:
                Roxie.fatalError("Not implemented.")

            case .Zip:
                Roxie.fatalError("Not implemented.")
        }

        return result
    }

// MARK: - Inner Types

    private struct Inner
    {
        static let DataScheme = "data"
        static let Base64Separator = ";base64"
        static let DataPrefix = ","
        static let ContentEncodingParamName = "e"
    }

    private enum ContentEncoding: String
    {
        case Gzip = "gzip"
        case Deflate = "deflate"
        case Zip = "zip"
    }

}

// ----------------------------------------------------------------------------

public enum DataUrlError: NestedError
{
// MARK: - Construction

    case FormatError(cause: Error?)
    case MediaTypeError(cause: Error?)
    case DataError(cause: Error?)
    case UnknownContentEncoding(cause: Error?)

// MARK: - Properties

    public var cause: Error? {
        switch self
        {
            case .FormatError(let cause):
                return cause

            case .MediaTypeError(let cause):
                return cause

            case .DataError(let cause):
                return cause

            case .UnknownContentEncoding(let cause):
                return cause
        }
    }
    
}

// ----------------------------------------------------------------------------
