// ----------------------------------------------------------------------------
//
//  OtpTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class OtpTask: VendorAbstractTask<VendorJsonBody, Void>
{
// MARK: - Construction

    init(builder: OtpTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.otp(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return OtpTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> OtpTaskBuilder {
        return OtpTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

}

// ----------------------------------------------------------------------------

open class OtpTaskBuilder: VendorAbstractTaskBuilder<VendorJsonBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: OtpTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> OtpTask {
        return OtpTask(builder: self)
    }
    
}

// ----------------------------------------------------------------------------
