// ----------------------------------------------------------------------------
//
//  CancelRideTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest
import SwiftCommonsDiagnostics

// ----------------------------------------------------------------------------

open class CancelRideTask: VendorAbstractTask<VendorJsonBody, Void>
{
// MARK: - Construction

    init(builder: CancelRideTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.rideCancellation(getRequestEntity().url!, id: self.options.id)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return CancelRideTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> CancelRideTaskBuilder {
        return CancelRideTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var id: Int!
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

// MARK: - Variables
    
    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class CancelRideTaskBuilder: VendorAbstractTaskBuilder<VendorJsonBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: CancelRideTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.id)
    }

    override open func newTask() -> CancelRideTask {
        return CancelRideTask(builder: self)
    }

    open func id(_ id: Int) -> Self {
        self.options.id = id
        return self
    }

// MARK: - Variables

    fileprivate var options = CancelRideTask.Options()

}

// ----------------------------------------------------------------------------
