// ----------------------------------------------------------------------------
//
//  RevokeTokenTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiHelpers
import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class RevokeTokenTask: VendorAbstractTask<FormBody, Void>
{
// MARK: - Construction

    init(builder: RevokeTokenTaskBuilder)
    {
        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func httpHeaders() -> HttpHeaders {
        return HttpHeadersUtils.merge(super.httpHeaders(), Inner.DefaultHttpHeaders)
    }

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.revokeToken(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return RevokeTokenTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> RevokeTokenTaskBuilder {
        return RevokeTokenTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

    fileprivate struct Inner
    {
        static let DefaultHttpHeaders = HttpHeaders([
            HttpHeaders.Header.Accept: MediaType.ApplicationJsonValue
        ])
    }

}

// ----------------------------------------------------------------------------

open class RevokeTokenTaskBuilder: VendorAbstractTaskBuilder<FormBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: RevokeTokenTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> RevokeTokenTask {
        return RevokeTokenTask(builder: self)
    }
   
}

// ----------------------------------------------------------------------------
