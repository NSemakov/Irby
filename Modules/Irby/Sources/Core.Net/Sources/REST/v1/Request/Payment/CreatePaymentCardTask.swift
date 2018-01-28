// ----------------------------------------------------------------------------
//
//  CreatePaymentCardTask.swift
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

open class CreatePaymentCardTask: VendorAbstractTask<VoidBody, CreatePaymentCardModel>
{
// MARK: - Construction

    init(builder: CreatePaymentCardTaskBuilder) {
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.cards(getRequestEntity().url!)
        return newClient().post(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<CreatePaymentCardModel> {
        return CreatePaymentCardTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> CreatePaymentCardTaskBuilder {
        return CreatePaymentCardTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<CreatePaymentCardModel>()

}

// ----------------------------------------------------------------------------

open class CreatePaymentCardTaskBuilder: VendorAbstractTaskBuilder<VoidBody, CreatePaymentCardModel>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: CreatePaymentCardTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> CreatePaymentCardTask {
        return CreatePaymentCardTask(builder: self)
    }
    
}

// ----------------------------------------------------------------------------
