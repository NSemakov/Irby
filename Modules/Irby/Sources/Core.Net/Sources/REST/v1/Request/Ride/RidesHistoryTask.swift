// ----------------------------------------------------------------------------
//
//  RidesHistoryTask.swift
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

open class RidesHistoryTask: VendorAbstractTask<VoidBody, PaginatedCollectionModel<RideModel>>
{
// MARK: - Construction

    init(builder: RidesHistoryTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.rides(getRequestEntity().url!, count: self.options.count, offset: self.options.offset)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<PaginatedCollectionModel<RideModel>> {
        return RidesHistoryTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> RidesHistoryTaskBuilder {
        return RidesHistoryTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var count: Int!
        var offset: Int!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableModelConverter<PaginatedCollectionModel<RideModel>>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class RidesHistoryTaskBuilder: VendorAbstractTaskBuilder<VoidBody, PaginatedCollectionModel<RideModel>>
{
// MARK: - Construction
    
    public override init() {
        super.init()
    }
    
    public init(task: RidesHistoryTask)
    {
        // Init instance variables
        self.options = task.options
        
        // Parent processing
        super.init(task: task)
    }
    
// MARK: - Methods
    
    override open func newTask() -> RidesHistoryTask {
        return RidesHistoryTask(builder: self)
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
    
    fileprivate var options = RidesHistoryTask.Options()
    
}

// ----------------------------------------------------------------------------
