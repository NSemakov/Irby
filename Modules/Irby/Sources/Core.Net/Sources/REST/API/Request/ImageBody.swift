// ----------------------------------------------------------------------------
//
//  ImageBody.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiHttp
import NetworkingApiRest
import UIKit

// ----------------------------------------------------------------------------

open class ImageBody: HttpBody
{
// MARK: - Construction

    public init(image: UIImage)
    {
        // Init instance variables
        self.image = image
    }

// MARK: - Properties

    open var mediaType: MediaType? {
        return MediaType.ImageJpeg
    }

    open var body: Data? {
        return UIImageJPEGRepresentation(self.image, 0.9)
    }

// MARK: - Variables

    fileprivate let image: UIImage

}

// ----------------------------------------------------------------------------
