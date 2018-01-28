// ----------------------------------------------------------------------------
//
//  CreateRouteTask.swift
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

open class CreateRideTask: VendorAbstractTask<SerializableObjectBody<NewRideParametersModel>, RideModel>
{
// MARK: - Construction

    init(builder: CreateRideTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.rides(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<RideModel> {
        return CreateRideTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> CreateRideTaskBuilder {
        return CreateRideTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<RideModel>()

}

// ----------------------------------------------------------------------------

open class CreateRideTaskBuilder: VendorAbstractTaskBuilder<SerializableObjectBody<NewRideParametersModel>, RideModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: CreateRideTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> CreateRideTask {
        return CreateRideTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
