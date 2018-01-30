// ----------------------------------------------------------------------------
//
//  ApiVersionRequestInterceptor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiHttp
import NetworkingApiRest
import SwiftCommonsLang

// ----------------------------------------------------------------------------

class ApiVersionRequestInterceptor: Interceptor
{
// MARK: - Construction

    init(version: RestApiVersion)
    {
        // Init instance variables
        self.version = version
    }

// MARK: - Methods

    func intercept(_ chain: InterceptorChain) throws -> HttpResponse
    {
        var request = chain.request
        var headers = HttpHeaders(request.allHTTPHeaderFields ?? [:])

        // Add version to Accept header
        headers.accept = headers.accept.map { mediaType in
            return interceptVersion(mediaType: mediaType)
        }

        // Add version to Content-Type header
        if let contentType = headers.contentType {
            headers.contentType = interceptVersion(mediaType: contentType)
        }

        // Replace original headers
        request.allHTTPHeaderFields = headers.allHeaderFields

        // Proceed request
        return try chain.proceed(request)
    }

// MARK: - Private Methods

    private func interceptVersion(mediaType: MediaType) -> MediaType
    {
        var params = mediaType.parameters

        // Add version parameter
        params[Inner.VersionParamsKey] = self.version.description

        // Init updated media type
        guard let result = MediaType(type: mediaType.type, subtype: mediaType.subtype, params: params) else {
            Roxie.fatalError("Can't create updated MediaType.")
        }

        // Done
        return result
    }

// MARK: - Constants

    private struct Inner {
        static let VersionParamsKey = "v"
    }

// MARK: - Variables

    private let version: RestApiVersion

}

// ----------------------------------------------------------------------------
