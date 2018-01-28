// ----------------------------------------------------------------------------
//
//  DeleteRideTask.swift
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

open class DeleteRideTask: VendorAbstractTask<VoidBody, Void>
{
// MARK: - Construction

    init(builder: DeleteRideTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.rides(getRequestEntity().url!, id: self.options.id)
        return newClient().delete(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return DeleteRideTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> DeleteRideTaskBuilder {
        return DeleteRideTaskBuilder(task: self)
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

open class DeleteRideTaskBuilder: VendorAbstractTaskBuilder<VoidBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: DeleteRideTask)
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

    override open func newTask() -> DeleteRideTask {
        return DeleteRideTask(builder: self)
    }

    open func id(_ id: Int) -> Self {
        self.options.id = id
        return self
    }

// MARK: - Variables

    fileprivate var options = DeleteRideTask.Options()

}

// ----------------------------------------------------------------------------
