// ----------------------------------------------------------------------------
//
//  PreflightTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class PreflightTask: VendorAbstractTask<VoidBody, PreflightModel>
{
// MARK: - Construction

    init(builder: PreflightTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.preflight(getRequestEntity().url!)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<PreflightModel> {
        return PreflightTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> PreflightTaskBuilder {
        return PreflightTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<PreflightModel>()

}

// ----------------------------------------------------------------------------

open class PreflightTaskBuilder: VendorAbstractTaskBuilder<VoidBody, PreflightModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: PreflightTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> PreflightTask {
        return PreflightTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
