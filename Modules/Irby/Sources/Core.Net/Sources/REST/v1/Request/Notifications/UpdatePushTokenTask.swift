// ----------------------------------------------------------------------------
//
//  UpdatePushTokenTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class UpdatePushTokenTask: VendorAbstractTask<FormBody, Void>
{
// MARK: - Construction

    init(builder: UpdatePushTokenTaskBuilder)
    {
        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.notifications(getRequestEntity().url!)
        return newClient().put(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return UpdatePushTokenTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> UpdatePushTokenTaskBuilder {
        return UpdatePushTokenTaskBuilder(task: self)
    }

// MARK: - Inner Types

    // ...

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

// MARK: - Variables

    // ...

}

// ----------------------------------------------------------------------------

open class UpdatePushTokenTaskBuilder: VendorAbstractTaskBuilder<FormBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: UpdatePushTokenTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> UpdatePushTokenTask {
        return UpdatePushTokenTask(builder: self)
    }

// MARK: - Variables

    // ...
    
}

// ----------------------------------------------------------------------------
