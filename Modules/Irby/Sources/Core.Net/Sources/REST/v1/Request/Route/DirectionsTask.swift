// ----------------------------------------------------------------------------
//
//  DirectionsTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import CoreLocation
import NetworkingApiConverters
import NetworkingApiRest
import SwiftCommonsDiagnostics
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class DirectionsTask: VendorAbstractTask<VoidBody, DirectionsModel>
{
// MARK: - Construction

    init(builder: DirectionsTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = DirectionsApiRoute.directions(origin: self.options.origin, destination: self.options.destination, departure: self.options.departure, alternatives: self.options.alternatives, key: self.options.key, avoid: self.options.avoid)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<DirectionsModel> {
        return DirectionsTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> DirectionsTaskBuilder {
        return DirectionsTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var origin: String!
        var destination: String!
        var departure: Int64!
        var alternatives = false
        var key: String!
        var avoid: [AvoidType]?
    }

    public enum AvoidType: String
    {
        case tolls = "tolls"
        case highways = "highways"
        case ferries = "ferries"
        case indoor = "indoor"
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<DirectionsModel>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class DirectionsTaskBuilder: VendorAbstractTaskBuilder<VoidBody, DirectionsModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: DirectionsTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.origin)
        Guard.notNil(self.options.destination)
        Guard.notNil(self.options.departure)
        Guard.notNil(self.options.key)
    }

    override open func newTask() -> DirectionsTask {
        return DirectionsTask(builder: self)
    }

    open func origin(_ origin: CLLocationCoordinate2D) -> Self
    {
        self.options.origin = locationToString(location: origin)
        return self
    }

    open func destination(_ destination: CLLocationCoordinate2D) -> Self
    {
        self.options.destination = locationToString(location: destination)
        return self
    }

    open func departure(_ departure: Date) -> Self
    {
        self.options.departure = Int64(departure.timeIntervalSince1970)
        return self
    }

    open func alternatives(_ alternatives: Bool) -> Self
    {
        self.options.alternatives = alternatives
        return self
    }

    open func key(_ key: String) -> Self
    {
        self.options.key = key
        return self
    }

    open func avoid(_ avoid: [DirectionsTask.AvoidType]?) -> Self
    {
        self.options.avoid = avoid
        return self
    }

// MARK: - Private Methods

    fileprivate func locationToString(location: CLLocationCoordinate2D) -> String
    {
        return "\(location.latitude),\(location.longitude)"
    }

// MARK: - Variables

    fileprivate var options = DirectionsTask.Options()
    
}

// ----------------------------------------------------------------------------
