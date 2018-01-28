// ----------------------------------------------------------------------------
//
//  DeletePlaceTask.swift
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

open class DeletePlaceTask: VendorAbstractTask<VoidBody, Void>
{
// MARK: - Construction

    init(builder: DeletePlaceTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.places(getRequestEntity().url!, id: self.options.id)
        return newClient().delete(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return DeletePlaceTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> DeletePlaceTaskBuilder {
        return DeletePlaceTaskBuilder(task: self)
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

open class DeletePlaceTaskBuilder: VendorAbstractTaskBuilder<VoidBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: DeletePlaceTask)
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

    override open func newTask() -> DeletePlaceTask {
        return DeletePlaceTask(builder: self)
    }

    open func id(_ id: Int) -> Self {
        self.options.id = id
        return self
    }

// MARK: - Variables

    fileprivate var options = DeletePlaceTask.Options()
    
}

// ----------------------------------------------------------------------------
