// ----------------------------------------------------------------------------
//
//  SendPromoTask.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest
import TaxiBookingCoreEntities

// ----------------------------------------------------------------------------

open class SendPromoTask: VendorAbstractTask<VendorJsonBody, CouponModel>
{
// MARK: - Construction

    init(builder: SendPromoTaskBuilder)
    {
        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.promo(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<CouponModel> {
        return SendPromoTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> SendPromoTaskBuilder {
        return SendPromoTaskBuilder(task: self)
    }

// MARK: - Inner Types

    // ...

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<CouponModel>()

// MARK: - Variables

    // ...

}

// ----------------------------------------------------------------------------

open class SendPromoTaskBuilder: VendorAbstractTaskBuilder<VendorJsonBody, CouponModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: SendPromoTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> SendPromoTask {
        return SendPromoTask(builder: self)
    }

// MARK: - Variables

    // ...
    
}

// ----------------------------------------------------------------------------

