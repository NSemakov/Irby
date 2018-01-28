// ----------------------------------------------------------------------------
//
//  BankCardsTask.swift
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

open class PaymentCardsTask: VendorAbstractTask<VoidBody, [PaymentCardModel]>
{
// MARK: - Construction

    init(builder: PaymentCardsTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.cards(getRequestEntity().url!)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[PaymentCardModel]> {
        return PaymentCardsTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> PaymentCardsTaskBuilder {
        return PaymentCardsTaskBuilder(task: self)
    }

// MARK: - Inner Types

    // ...

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelArrayConverter<PaymentCardModel>()

// MARK: - Variables

    // ...

}

// ----------------------------------------------------------------------------

open class PaymentCardsTaskBuilder: VendorAbstractTaskBuilder<VoidBody, [PaymentCardModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: PaymentCardsTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> PaymentCardsTask {
        return PaymentCardsTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
