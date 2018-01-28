// ----------------------------------------------------------------------------
//
//  ReverseGeocodeTask.swift
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
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class ReverseGeocodeTask: VendorAbstractTask<VoidBody, [GeoPointModel]>
{
// MARK: - Construction

    init(builder: ReverseGeocodeTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let latlng = String(format: Inner.LatLngFormat, locale: Inner.Locale, self.options.location.latitude, self.options.location.longitude)
        let route = RestApiRoute.geocode(getRequestEntity().url!, latlng: latlng)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[GeoPointModel]> {
        return ReverseGeocodeTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> ReverseGeocodeTaskBuilder {
        return ReverseGeocodeTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var location: LocationModel!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelArrayConverter<GeoPointModel>()

    fileprivate struct Inner
    {
        static let LatLngFormat = "%.6f,%.6f"
        static let Locale = Foundation.Locale(identifier: "en_US_POSIX")
    }

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class ReverseGeocodeTaskBuilder: VendorAbstractTaskBuilder<VoidBody, [GeoPointModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: ReverseGeocodeTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.location)
    }

    override open func newTask() -> ReverseGeocodeTask {
        return ReverseGeocodeTask(builder: self)
    }

    open func location(_ location: LocationModel) -> Self {
        self.options.location = location
        return self
    }

// MARK: - Variables

    fileprivate var options = ReverseGeocodeTask.Options()
    
}

// ----------------------------------------------------------------------------
