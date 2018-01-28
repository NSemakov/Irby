// ----------------------------------------------------------------------------
//
//  SerializableObjectBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import SwiftCommonsData

// ----------------------------------------------------------------------------

open class SerializableObjectBody<T: ValidatableModel>: VendorJsonBody
{
// MARK: - Construction

    public init(model: T) {
        super.init(body: Mapper().toJSON(model))
    }

}

// ----------------------------------------------------------------------------
