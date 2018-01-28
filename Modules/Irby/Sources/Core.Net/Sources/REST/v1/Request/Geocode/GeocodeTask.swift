// ----------------------------------------------------------------------------
//
//  GeocodeTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiHttp
import NetworkingApiRest
import SwiftCommonsDiagnostics
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class GeocodeTask: VendorAbstractTask<VoidBody, [GeoPointModel]>
{
// MARK: - Construction

    init(builder: GeocodeTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.geocode(getRequestEntity().url!, address: self.options.address)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[GeoPointModel]> {
        return GeocodeTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> GeocodeTaskBuilder {
        return GeocodeTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var address: String!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelArrayConverter<GeoPointModel>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class GeocodeTaskBuilder: VendorAbstractTaskBuilder<VoidBody, [GeoPointModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: GeocodeTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.address)
    }

    override open func newTask() -> GeocodeTask {
        return GeocodeTask(builder: self)
    }

    open func address(_ address: String) -> Self {
        self.options.address = address
        return self
    }

// MARK: - Variables

    fileprivate var options = GeocodeTask.Options()
    
}

// ----------------------------------------------------------------------------
