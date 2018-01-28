// ----------------------------------------------------------------------------
//
//  CreatePlaceTask.swift
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

open class CreatePlaceTask: VendorAbstractTask<SerializableObjectBody<GeoPointModel>, PlaceModel>
{
// MARK: - Construction

    init(builder: CreatePlaceTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        // TODO: Handle self.option.placeType parameter
        // ...

        let route = RestApiRoute.places(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<PlaceModel> {
        return CreatePlaceTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> CreatePlaceTaskBuilder {
        return CreatePlaceTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var placeType: PlaceType?
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<PlaceModel>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class CreatePlaceTaskBuilder: VendorAbstractTaskBuilder<SerializableObjectBody<GeoPointModel>, PlaceModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: CreatePlaceTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> CreatePlaceTask {
        return CreatePlaceTask(builder: self)
    }

    open func placeType(_ placeType: PlaceType?) -> Self {
        self.options.placeType = placeType
        return self
    }

// MARK: - Variables

    fileprivate var options = CreatePlaceTask.Options()
    
}

// ----------------------------------------------------------------------------
