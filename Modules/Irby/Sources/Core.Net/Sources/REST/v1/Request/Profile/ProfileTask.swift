// ----------------------------------------------------------------------------
//
//  ProfileTask.swift
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

open class ProfileTask: VendorAbstractTask<VoidBody, UserProfileModel>
{
// MARK: - Construction

    init(builder: ProfileTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.profile(getRequestEntity().url!)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<UserProfileModel> {
        return ProfileTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> ProfileTaskBuilder {
        return ProfileTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<UserProfileModel>()

}

// ----------------------------------------------------------------------------

open class ProfileTaskBuilder: VendorAbstractTaskBuilder<VoidBody, UserProfileModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: ProfileTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> ProfileTask {
        return ProfileTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
