// ----------------------------------------------------------------------------
//
//  DeleteBankCardTask.swift
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

open class DeleteBankCardTask: VendorAbstractTask<VoidBody, Void>
{
// MARK: - Construction

    init(builder: DeleteBankCardTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.cards(getRequestEntity().url!, bindingId: self.options.bindingId)
        return newClient().delete(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return DeleteBankCardTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> DeleteBankCardTaskBuilder {
        return DeleteBankCardTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var bindingId: String!
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class DeleteBankCardTaskBuilder: VendorAbstractTaskBuilder<VoidBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: DeleteBankCardTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.bindingId)
    }

    override open func newTask() -> DeleteBankCardTask {
        return DeleteBankCardTask(builder: self)
    }

    open func bindingId(_ bindingId: String) -> Self {
        self.options.bindingId = bindingId
        return self
    }

// MARK: - Variables

    fileprivate var options = DeleteBankCardTask.Options()

}

// ----------------------------------------------------------------------------
