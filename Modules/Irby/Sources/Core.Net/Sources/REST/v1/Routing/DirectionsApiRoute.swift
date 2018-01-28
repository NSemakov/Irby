// ----------------------------------------------------------------------------
//
//  DirectionsApiRoute.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHelpers
import NetworkingApiRest
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public final class DirectionsApiRoute: NonCreatable
{
// MARK: - Methods: Directions

    // GET
    public static func directions(origin: String, destination: String, departure: Int64, alternatives: Bool, key: String, avoid: [DirectionsTask.AvoidType]?) -> HttpRoute
    {
        let params: QueryParams = [
            HttpKeys.Origin: origin,
            HttpKeys.Destination: destination,
            HttpKeys.DepartureTime: String(departure),
            HttpKeys.Key : key,
            HttpKeys.Alternatives : String(alternatives)
        ]

        if let avoid = avoid, !(avoid.isEmpty)
        {
            let avoidParams = avoid.flatMap{ $0.rawValue }.joined(separator: "|")
            params.add(HttpKeys.Avoid, avoidParams)
        }

        return HttpRoute.buildRoute(Inner.BaseURL, path: nil, params: params)
    }

// MARK: - Constants

    fileprivate struct Inner {
        static let BaseURL = URL(string: "https://maps.googleapis.com/maps/api/directions/json")!
    }

}

// ----------------------------------------------------------------------------
