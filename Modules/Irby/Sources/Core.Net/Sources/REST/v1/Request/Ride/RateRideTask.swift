// ----------------------------------------------------------------------------
//
//  RateRideTask.swift
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

// ----------------------------------------------------------------------------

open class RateRideTask: VendorAbstractTask<VendorJsonBody, Void>
{
// MARK: - Construction

    init(builder: RateRideTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.rideRating(getRequestEntity().url!, id: self.options.id )
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return RateRideTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> RateRideTaskBuilder {
        return RateRideTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var id: Int!
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class RateRideTaskBuilder: VendorAbstractTaskBuilder<VendorJsonBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: RateRideTask) {
        // Init instance variables
        self.options = task.options

        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.id)
    }

    override open func newTask() -> RateRideTask {
        return RateRideTask(builder: self)
    }

    open func id(_ id: Int) -> Self {
        self.options.id = id
        return self
    }

// MARK: - Variables

    fileprivate var options = RateRideTask.Options()

}

// ----------------------------------------------------------------------------
