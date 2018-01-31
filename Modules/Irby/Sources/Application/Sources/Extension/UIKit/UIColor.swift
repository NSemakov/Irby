// ----------------------------------------------------------------------------
//
//  UIColor.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

extension UIColor
{
// MARK: - Constants

    static var defaultTintColor: UIColor
    {
        struct Singleton {
            static let instance = UIColor(red: (255.0/255.0), green: (104.0/255.0), blue: (1.0/255.0), alpha: 1.0)
        }
        return Singleton.instance
    }

    static var errorBackgroundRedColor: UIColor
    {
        struct Singleton {
            static let instance = UIColor(red: (253.0/255.0), green: (238.0/255.0), blue: (238.0/255.0), alpha: 1.0)
        }
        return Singleton.instance
    }

    static var errorFontRedColor: UIColor
    {
        struct Singleton {
            static let instance = UIColor(red: (253.0/255.0), green: (64.0/255.0), blue: (54.0/255.0), alpha: 1.0)
        }
        return Singleton.instance
    }

    static var selectedButtonColor: UIColor
    {
        struct Singleton {
            static let instance = UIColor(red: (91.0/255.0), green: (124.0/255.0), blue: (227.0/255.0), alpha: 1.0)
        }
        return Singleton.instance
    }

    static var routeBlueColor: UIColor
    {
        struct Singleton {
            static let instance = UIColor(red: (91.0/255.0), green: (124.0/255.0), blue: (227.0/255.0), alpha: 0.7)
        }
        return Singleton.instance
    }

}

// ----------------------------------------------------------------------------
