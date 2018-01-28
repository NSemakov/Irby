// ----------------------------------------------------------------------------
//
//  RidesWaypointsPickupTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

public class RidesWaypointsPickupTask: VendorAbstractTask<VoidBody, [WayPointModel]>
{
// MARK: - Construction

    init(builder: RidesWaypointsPickupTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override public func callExecute() -> HttpResult
    {
        let route = RestApiRoute.ridesWaypointsPickup(getRequestEntity().url!)
        return newClient().get(newRequestEntity(route))
    }

    override public func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[WayPointModel]> {
        return RidesWaypointsPickupTask.Converter.convert(httpResult)
    }

    override public func newBuilder() -> RidesWaypointsPickupTaskBuilder {
        return RidesWaypointsPickupTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelArrayConverter<WayPointModel>()

}

// ----------------------------------------------------------------------------

public class RidesWaypointsPickupTaskBuilder: VendorAbstractTaskBuilder<VoidBody, [WayPointModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: RidesWaypointsPickupTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override public func newTask() -> RidesWaypointsPickupTask {
        return RidesWaypointsPickupTask(builder: self)
    }

    
}

// ----------------------------------------------------------------------------
