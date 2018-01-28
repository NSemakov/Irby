// ----------------------------------------------------------------------------
//
//  SendFeedbackTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class SendFeedbackTask: VendorAbstractTask<StringBody, Void>
{
// MARK: - Construction

    init(builder: SendFeedbackTaskBuilder)
    {
        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.feedback(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return SendFeedbackTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> SendFeedbackTaskBuilder {
        return SendFeedbackTaskBuilder(task: self)
    }

// MARK: - Inner Types

    // ...

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

// MARK: - Variables

    // ...

}

// ----------------------------------------------------------------------------

open class SendFeedbackTaskBuilder: VendorAbstractTaskBuilder<StringBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: SendFeedbackTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> SendFeedbackTask {
        return SendFeedbackTask(builder: self)
    }

// MARK: - Variables

    // ...
    
}

// ----------------------------------------------------------------------------
