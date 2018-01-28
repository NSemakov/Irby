// ----------------------------------------------------------------------------
//
//  UpdateSettingsTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class UpdateSettingsTask: VendorAbstractTask<SerializableObjectBody<UserSettingsModel>, Void>
{
// MARK: - Construction

    init(builder: UpdateSettingsTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Properties

    // ...

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.settings(getRequestEntity().url!)
        return newClient().put(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return UpdateSettingsTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> UpdateSettingsTaskBuilder {
        return UpdateSettingsTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

}

// ----------------------------------------------------------------------------

open class UpdateSettingsTaskBuilder: VendorAbstractTaskBuilder<SerializableObjectBody<UserSettingsModel>, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: UpdateSettingsTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> UpdateSettingsTask {
        return UpdateSettingsTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
