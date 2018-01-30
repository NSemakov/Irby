// ----------------------------------------------------------------------------
//
//  ValidatableHTMLModelArrayConverter.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Kanna
import NetworkingApiConverters
import NetworkingApiHttp
import NetworkingApiRest
import SwiftCommonsData
import SwiftyJSON

// ----------------------------------------------------------------------------

open class ValidatableHTMLModelArrayConverter<T: ValidatableModel>: AbstractCallResultConverter<[T]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

// MARK: - Functions

    open override func convert(_ entity: ResponseEntity<Ti>) throws -> ResponseEntity<To> {
        var newEntity: ResponseEntity<To>
        var newBody: [T]?

        if let body = entity.body, body.isNotEmpty {
            do {
                // Try to parse response body as JSON array

                let doc = try HTML(html: body, encoding: .utf8)
                print(doc)
                
//                if let jsonArray = try JSON(data: body, options: .allowFragments).object as? JsonArray {
//
//                    newBody = try jsonArray.enumerated().map { (index, element) in
//                        if let jsonObject = element as? JsonObject {
//                            return try T.init(from: jsonObject)
//                        }
//                        else {
//                            throw JsonSyntaxError(message: "Failed to convert element of array[\(index)] to JSON object.")
//                        }
//                    }
//                }
//                else {
//                    throw JsonSyntaxError(message: "Failed to convert response body to JSON array.")
//                }
            }
            catch {
                print(error)
                let a = 2
//                throw ConversionError(entity: entity, cause: error)
            }
        }

        // Create response entity
        newEntity = BasicResponseEntityBuilder(entity: entity, body: newBody).build()
        return newEntity
    }

    open override func supportedMediaTypes() -> [MediaType] {
        return [
            MediaType.All
        ]
    }
}

// ----------------------------------------------------------------------------

