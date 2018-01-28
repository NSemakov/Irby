// ----------------------------------------------------------------------------
//
//  PlacesTask.swift
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

open class PlacesTask: VendorAbstractTask<VoidBody, PaginatedCollectionModel<PlaceModel>>
{
// MARK: - Construction

    init(builder: PlacesTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.places(getRequestEntity().url!, count: self.options.count, offset: self.options.offset)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<PaginatedCollectionModel<PlaceModel>> {
        return PlacesTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> PlacesTaskBuilder {
        return PlacesTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var count: Int!
        var offset: Int!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<PaginatedCollectionModel<PlaceModel>>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class PlacesTaskBuilder: VendorAbstractTaskBuilder<VoidBody, PaginatedCollectionModel<PlaceModel>>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: PlacesTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> PlacesTask {
        return PlacesTask(builder: self)
    }

    open func count(_ count: Int) -> Self {
        self.options.count = count
        return self
    }

    open func offset(_ offset: Int) -> Self {
        self.options.offset = offset
        return self
    }

// MARK: - Variables

    fileprivate var options = PlacesTask.Options()

}

// ----------------------------------------------------------------------------
