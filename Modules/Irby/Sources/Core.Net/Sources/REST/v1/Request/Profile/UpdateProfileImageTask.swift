// ----------------------------------------------------------------------------
//
//  UpdateProfileImageTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class UpdateProfileImageTask: VendorAbstractTask<ImageBody, Void>
{
// MARK: - Construction

    init(builder: UpdateProfileImageTaskBuilder)
    {
        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.profileAvatar(getRequestEntity().url!)
        return newClient().put(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<Void> {
        return UpdateProfileImageTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> UpdateProfileImageTaskBuilder {
        return UpdateProfileImageTaskBuilder(task: self)
    }

// MARK: - Constants

    fileprivate static let Converter = VoidConverter()

}

// ----------------------------------------------------------------------------

open class UpdateProfileImageTaskBuilder: VendorAbstractTaskBuilder<ImageBody, Void>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: UpdateProfileImageTask) {
        super.init(task: task)
    }

// MARK: - Methods

    override open func newTask() -> UpdateProfileImageTask {
        return UpdateProfileImageTask(builder: self)
    }

}

// ----------------------------------------------------------------------------
