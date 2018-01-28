// ----------------------------------------------------------------------------
//
//  VendorAbstractTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiHelpers
import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class VendorAbstractTask<Ti: HttpBody, To>: AbstractTask<Ti, To>
{
// MARK: - Construction

    init(builder: VendorAbstractTaskBuilder<Ti, To>)
    {
        // Init instance variables
        self.httpClientConfig = builder.httpClientConfig

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    open override func getHttpClientConfig() -> HttpClientConfig {
        return self.httpClientConfig
    }

    open override func httpHeaders() -> HttpHeaders {
        return HttpHeadersUtils.merge(super.httpHeaders(), Inner.DefaultHttpHeaders)
    }

// MARK: - Inner Types

    fileprivate typealias Inner = VendorAbstractTaskInner

// MARK: - Variables

    fileprivate let httpClientConfig: HttpClientConfig

}

// ----------------------------------------------------------------------------

fileprivate struct VendorAbstractTaskInner
{
// MARK: - Constants

    static let DefaultHttpHeaders = HttpHeaders([
        HttpHeaders.Header.Accept: MediaType.ApplicationVndBlackbirdTaxiBookingJsonValue
    ])

}

// ----------------------------------------------------------------------------

open class VendorAbstractTaskBuilder<Ti: HttpBody, To>: AbstractTaskBuilder<Ti, To>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: VendorAbstractTask<Ti, To>)
    {
        // Init instance variables
        self.httpClientConfig = task.httpClientConfig

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    open func httpClientConfig(_ httpClientConfig: HttpClientConfig) -> Self {
        self.httpClientConfig = httpClientConfig
        return self
    }

// MARK: - Inner Types

    fileprivate typealias Inner = VendorAbstractTaskBuilderInner

// MARK: - Variables
    
    fileprivate var httpClientConfig: HttpClientConfig = Inner.VendorHttpClientConfig

}

// ----------------------------------------------------------------------------

fileprivate struct VendorAbstractTaskBuilderInner
{
// MARK: - Constants

    static let VendorHttpClientConfig = DefaultHttpClientConfig()

}

// ----------------------------------------------------------------------------
