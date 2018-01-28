// ----------------------------------------------------------------------------
//
//  CreateTokenTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiHelpers
import NetworkingApiHttp
import NetworkingApiRest
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class CreateTokenTask: VendorAbstractTask<FormBody, TokenModel>
{
// MARK: - Construction

    init(builder: CreateTokenTaskBuilder)
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
        let route = RestApiRoute.token(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<TokenModel> {
        return CreateTokenTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> CreateTokenTaskBuilder {
        return CreateTokenTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<TokenModel>()

    fileprivate struct Inner
    {
        static let DefaultHttpHeaders = HttpHeaders([
            HttpHeaders.Header.Accept: MediaType.ApplicationJsonValue
        ])
    }

}

// ----------------------------------------------------------------------------

open class CreateTokenTaskBuilder: VendorAbstractTaskBuilder<FormBody, TokenModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: CreateTokenTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> CreateTokenTask {
        return CreateTokenTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
