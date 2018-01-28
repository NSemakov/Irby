// ----------------------------------------------------------------------------
//
//  NearbyTaxicabsTask.swift
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
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class NearbyTaxicabsTask: VendorAbstractTask<VoidBody, [NearbyTaxicabModel]>
{
// MARK: - Construction

    init(builder: NearbyTaxicabsTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let latlng = String(format: Inner.LatLngFormat, self.options.location.latitude, self.options.location.longitude)
        let route = RestApiRoute.nearbyTaxicabs(getRequestEntity().url!, latlng: latlng)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[NearbyTaxicabModel]> {
        return NearbyTaxicabsTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> NearbyTaxicabsTaskBuilder {
        return NearbyTaxicabsTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var location: LocationModel!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelArrayConverter<NearbyTaxicabModel>()

    fileprivate struct Inner {
        static let LatLngFormat = "%.6f,%.6f"
    }

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class NearbyTaxicabsTaskBuilder: VendorAbstractTaskBuilder<VoidBody, [NearbyTaxicabModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: NearbyTaxicabsTask)
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

    override open func newTask() -> NearbyTaxicabsTask {
        return NearbyTaxicabsTask(builder: self)
    }

    open func location(_ location: LocationModel) -> Self {
        self.options.location = location
        return self
    }
    
// MARK: - Variables
    
    fileprivate var options = NearbyTaxicabsTask.Options()
    
}

// ----------------------------------------------------------------------------
