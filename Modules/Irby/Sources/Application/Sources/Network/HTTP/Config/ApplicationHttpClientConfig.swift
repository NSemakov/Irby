// ----------------------------------------------------------------------------
//
//  ApplicationHttpClientConfig.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiRest

// ----------------------------------------------------------------------------

class ApplicationHttpClientConfig: DefaultHttpClientConfig
{
// MARK: - Construction

    fileprivate override init() { }

    static let SharedConfig = ApplicationHttpClientConfig()

// MARK: - Methods

    override func connectTimeout() -> TimeInterval {
        return 5.0
    }

    override func readTimeout() -> TimeInterval {
        return 5.0
    }

    override func networkInterceptors() -> [Interceptor] {
        var networkInterceptors: [Interceptor] = []

        // Interceptor which adds an api version to Accept and Content-Type headers
        networkInterceptors.append(ApiVersionRequestInterceptor(version: RestApiVersion.current))

        // Parent processing
        networkInterceptors.append(contentsOf: super.networkInterceptors())

        return networkInterceptors
    }

}

// ----------------------------------------------------------------------------
