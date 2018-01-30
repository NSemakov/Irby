// ----------------------------------------------------------------------------
//
//  EndpointManager.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsConcurrent
import SwiftCommonsLang

// ----------------------------------------------------------------------------

class EndpointManager
{
// MARK: - Construction

    static let defaultManager = EndpointManager()

    fileprivate init()
    {
        // ...
    }

// MARK: - Properties

    var baseURL: URL? {
        return URL(string: "https://www.amalgama-lab.com/songs")
    }
}

// ----------------------------------------------------------------------------
