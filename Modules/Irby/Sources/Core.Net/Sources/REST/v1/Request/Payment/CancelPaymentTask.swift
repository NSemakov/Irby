// ----------------------------------------------------------------------------
//
//  CancelPaymentTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest
import SwiftCommonsDiagnostics

// ----------------------------------------------------------------------------

open class CancelPaymentTask: VendorAbstractTask<VoidBody, Void>
{
// MARK: - Construction

    init(builder: CancelPaymentTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.paymentCancellation(getRequestEntity().url!, orderId: self.options.orderId)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return CancelPaymentTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> CancelPaymentTaskBuilder {
        return CancelPaymentTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var orderId: String!
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class CancelPaymentTaskBuilder: VendorAbstractTaskBuilder<VoidBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: CancelPaymentTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.orderId)
    }

    override open func newTask() -> CancelPaymentTask {
        return CancelPaymentTask(builder: self)
    }

    open func orderId(_ orderId: String) -> Self {
        self.options.orderId = orderId
        return self
    }

// MARK: - Variables

    fileprivate var options = CancelPaymentTask.Options()
    
}

// ----------------------------------------------------------------------------
