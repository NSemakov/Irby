// ----------------------------------------------------------------------------
//
//  StringBody.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

public class StringBody: HttpBody
{
// MARK: - Construction

    public init(string: String, encoding: String.Encoding = .utf8)
    {
        // Init instance variables
        self.text = string
        self.encoding = encoding
    }

// MARK: - Properties

    public var mediaType: MediaType? {
        return MediaType.TextPlain
    }

    public var body: Data? {
        return self.text.data(using: encoding)
    }

// MARK: - Variables

    fileprivate let text: String

    fileprivate let encoding: String.Encoding

}

// ----------------------------------------------------------------------------
