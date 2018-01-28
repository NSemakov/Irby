// ----------------------------------------------------------------------------
//
//  VendorJsonBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import NetworkingApiHttp
import NetworkingApiRest

// ----------------------------------------------------------------------------

open class VendorJsonBody: JsonBody
{
// MARK: - Methods

    open override var mediaType: MediaType? {
        return VendorJsonBody.MediaTypeVendorJson
    }

// MARK: - Constants

    fileprivate static let MediaTypeVendorJson =
            MediaType.valueOf(MediaType.ApplicationVndBlackbirdTaxiBookingJsonValue + "; charset=" + HttpKeys.EncodingName.UTF_8)

}

// ----------------------------------------------------------------------------
