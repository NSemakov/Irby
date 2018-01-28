// ----------------------------------------------------------------------------
//
//  RouteTask.swift
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

open class RideTask: VendorAbstractTask<VoidBody, RideModel>
{
// MARK: - Construction

    init(builder: RideTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.rides(getRequestEntity().url!, id: self.options.id)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<RideModel> {
        return RideTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> RideTaskBuilder {
        return RideTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var id: Int!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<RideModel>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class RideTaskBuilder: VendorAbstractTaskBuilder<VoidBody, RideModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: RideTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> RideTask {
        return RideTask(builder: self)
    }

    open func id(_ id: Int) -> Self {
        self.options.id = id
        return self
    }

// MARK: - Variables

    fileprivate var options = RideTask.Options()

}

// ----------------------------------------------------------------------------
