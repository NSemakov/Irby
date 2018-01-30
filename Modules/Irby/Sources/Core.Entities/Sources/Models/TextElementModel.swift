// ----------------------------------------------------------------------------
//
//  TextElementModel.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import SwiftCommonsData
import SwiftCommonsDiagnostics

// ----------------------------------------------------------------------------

public final class TextElementModel: ValidatableModel
{
// MARK: - Properties

    public fileprivate(set) var original: String!

    public fileprivate(set) var translation: String?

// MARK: - Methods

    open override func map(with map: Map) {
        super.map(with: map)

        // (De)serialize to/from json
        self.original    <~  map[JsonKeys.Original]
        self.translation <~  map[JsonKeys.Translation]
    }

    public override func validate() throws {
        try super.validate()

        // Validate instance
        try Check.notBlank(self.original)
    }
}

// ----------------------------------------------------------------------------
