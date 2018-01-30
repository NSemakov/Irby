// ----------------------------------------------------------------------------
//
//  RestApiVersion.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation

// ----------------------------------------------------------------------------

struct RestApiVersion
{
// MARK: - Construction

    static let current = RestApiVersion(major: 10, minor: 0)

    init(major: Int, minor: Int)
    {
        // Init instance variables
        self.major = major
        self.minor = minor
    }

    init?(version: String)
    {
        let components = version.components(separatedBy: ".")
        guard (components.count >= 2),
            let major = Int(components[0]),
            let minor = Int(components[1])
        else {
            return nil
        }

        self.major = major
        self.minor = minor
    }

// MARK: - Properties

    let major: Int

    let minor: Int

}

// ----------------------------------------------------------------------------

extension RestApiVersion: CustomStringConvertible, CustomDebugStringConvertible
{
// MARK: - Properties

    var description: String {
        return "\(self.major).\(self.minor)"
    }

    var debugDescription: String {
        return self.description
    }

}

// ----------------------------------------------------------------------------
