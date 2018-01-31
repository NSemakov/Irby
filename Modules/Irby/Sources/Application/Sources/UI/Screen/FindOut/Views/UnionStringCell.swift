// ----------------------------------------------------------------------------
//
//  SelectorGeoPointCell.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import IrbyCoreEntities
import UIKit

// ----------------------------------------------------------------------------

class UnionStringCell: UITableViewCell
{
// MARK: - Construction

    // ...

// MARK: - Properties

    @IBOutlet fileprivate(set) weak var originalLabel: UILabel!


    @IBOutlet fileprivate(set) weak var translateLabel: UILabel!

    // MARK: - Methods

    func updateView(_ textElement: TextElementModel)
    {
        self.originalLabel.text = textElement.original
        self.translateLabel.text = textElement.translation
    }

// MARK: - Actions

    // ...

// MARK: - Private Methods

    // ...

// MARK: - Inner Types

    // ...

// MARK: - Constants

    // ...

// MARK: - Variables
    
    // ...
    
}

// ----------------------------------------------------------------------------
