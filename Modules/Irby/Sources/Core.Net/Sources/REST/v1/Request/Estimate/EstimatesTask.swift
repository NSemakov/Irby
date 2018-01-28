// ----------------------------------------------------------------------------
//
//  EstimatesTask.swift
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

public final class EstimatesTask: VendorAbstractTask<VendorJsonBody, [EstimateModel]>
{
// MARK: - Construction

    init(builder: EstimatesTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    open override func callExecute() -> HttpResult {
        let route = RestApiRoute.estimates(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    open override func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[EstimateModel]> {
        return EstimatesTask.Converter.convert(httpResult)
    }

    open override func newBuilder() -> EstimatesTaskBuilder {
        return EstimatesTaskBuilder(task: self)
    }

// MARK: - Constants

    private static let Converter = ValidatableModelArrayConverter<EstimateModel>()
}

// ----------------------------------------------------------------------------

open class EstimatesTaskBuilder: VendorAbstractTaskBuilder<VendorJsonBody, [EstimateModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: EstimatesTask) {
        super.init(task: task)
    }

// MARK: - Methods

    open override func newTask() -> EstimatesTask {
        return EstimatesTask(builder: self)
    }
}

// ----------------------------------------------------------------------------
