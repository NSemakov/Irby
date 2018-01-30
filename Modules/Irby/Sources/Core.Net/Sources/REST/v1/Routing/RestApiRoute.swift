// ----------------------------------------------------------------------------
//
//  RestApiRoute.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHelpers
import NetworkingApiRest
import SwiftCommonsLang

// ----------------------------------------------------------------------------

public final class RestApiRoute: NonCreatable
{
// MARK: - Methods

    // GET
    public static func base(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL)
    }

// MARK: - Methods: Amalgama

    // GET
    public static func song(_ baseURL: URL, title: String, artist: String) -> HttpRoute
    {
        if let firstLetter = artist.lowercased().first {
             return HttpRoute.buildRoute(baseURL, path: "/\(firstLetter)/\(artist.lowercased())/\(title.lowercased()).html")
        }
        else {
            Roxie.fatalError("Can't get first letter of artist \(artist)")
        }
    }
}

// ----------------------------------------------------------------------------
