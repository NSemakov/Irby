// ----------------------------------------------------------------------------
//
//  UpdateProfileTask.swift
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

open class UpdateProfileTask: VendorAbstractTask<SerializableObjectBody<UserProfileModel>, Void>
{
// MARK: - Construction

    init(builder: UpdateProfileTaskBuilder)
    {
        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.profile(getRequestEntity().url!)
        return newClient().patch(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return UpdateProfileTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> UpdateProfileTaskBuilder {
        return UpdateProfileTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

}

// ----------------------------------------------------------------------------

open class UpdateProfileTaskBuilder: VendorAbstractTaskBuilder<SerializableObjectBody<UserProfileModel>, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: UpdateProfileTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> UpdateProfileTask {
        return UpdateProfileTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
