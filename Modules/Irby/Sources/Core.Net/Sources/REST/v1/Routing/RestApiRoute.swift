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

// MARK: - Methods: Authentication

    // POST
    public static func token(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/oauth/token")
    }

    // POST
    public static func revokeToken(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/oauth/revoke")
    }

    // POST
    public static func otp(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/otp")
    }

// MARK: - Methods: Preflight

    // GET
    public static func preflight(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/self")
    }

// MARK: - Methods: Rides

    // GET
    public static func rides(_ baseURL: URL, count: Int, offset: Int) -> HttpRoute
    {
        let params: QueryParams = [
            HttpKeys.Count: String(count),
            HttpKeys.Offset: String(offset)
        ]
        return HttpRoute.buildRoute(baseURL, path: "/rides", params: params)
    }

    // POST
    public static func rides(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/rides")
    }

    // DELETE
    public static func rides(_ baseURL: URL, id: Int) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/rides/\(id)")
    }

    // POST
    public static func rideCancellation(_ baseURL: URL, id: Int) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/rides/\(id)/cancellation")
    }

    // POST
    public static func rideRating(_ baseURL: URL, id: Int) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/rides/\(id)/rating")
    }

    // GET
    public static func ridesWaypointsPickup(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/rides/waypoints/pickup")
    }

// MARK: - Methods: Nearby Taxicabs

    // GET
    public static func nearbyTaxicabs(_ baseURL: URL, latlng: String) -> HttpRoute
    {
        let params: QueryParams = [HttpKeys.LatLng: latlng]
        return HttpRoute.buildRoute(baseURL, path: "/taxicabs/nearby", params: params)
    }

// MARK: - Methods: Places

    // GET
    public static func places(_ baseURL: URL, count: Int, offset: Int) -> HttpRoute
    {
        let params: QueryParams = [
            HttpKeys.Count: String(count),
            HttpKeys.Offset: String(offset)
        ]
        return HttpRoute.buildRoute(baseURL, path: "/places", params: params)
    }

    // POST
    public static func places(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/places")
    }

    // DELETE
    public static func places(_ baseURL: URL, id: Int) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/places/\(id)")
    }

// MARK: - Methods: Profile

    // PUT
    public static func profile(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/profile")
    }

    // PUT
    public static func profileAvatar(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/profile/avatar")
    }

// MARK: - Methods: Settings

    // PUT
    public static func settings(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/profile/preferences")
    }

// MARK: - Methods: Geocode

    // GET
    public static func geocode(_ baseURL: URL, latlng: String) -> HttpRoute
    {
        let params: QueryParams = [HttpKeys.LatLng: latlng]
        return HttpRoute.buildRoute(baseURL, path: "/geocode", params: params)
    }

    // GET
    public static func geocode(_ baseURL: URL, address: String) -> HttpRoute
    {
        let params: QueryParams = [HttpKeys.Address: address]
        return HttpRoute.buildRoute(baseURL, path: "/geocode", params: params)
    }

// MARK: - Methods: Estimates

    // POST
    public static func estimates(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/estimates")
    }

// MARK: - Methods: Bank Cards

    // DELETE
    public static func cards(_ baseURL: URL, bindingId: String) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/cards/\(bindingId)")
    }

    // FIXME: need proper route
    // GET
    public static func cards(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/cards")
    }

    // FIXME: need proper route
    // GET
    public static func payments(_ baseURL: URL, orderId: String) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/payments/\(orderId)")
    }

    // POST
    public static func paymentCancellation(_ baseURL: URL, orderId: String) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/payments/\(orderId)/cancellation")
    }

// MARK: - Methods: Promo

    // POST
    public static func promo(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/promotions/activation")
    }

// MARK: - Methods: Feedback

    // POST
    public static func feedback(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/feedback")
    }

// MARK: - Methods: Push

    // PUT
    public static func notifications(_ baseURL: URL) -> HttpRoute {
        return HttpRoute.buildRoute(baseURL, path: "/notifications/registration")
    }

}

// ----------------------------------------------------------------------------
