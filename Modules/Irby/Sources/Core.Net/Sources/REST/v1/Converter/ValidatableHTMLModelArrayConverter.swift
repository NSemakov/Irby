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
import SwiftCommonsLang
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
                let doc = try HTML(html: body, encoding: .windowsCP1251)

                var jsonArray = [JsonObject]()
                for link in doc.xpath("//div[@class='string_container']") {
                    if let text = link.text {
                       let originalAndTranslation = text.components(separatedBy: "\r")
                        if let originalSubstring = originalAndTranslation.first,
                           let translateSubstring = originalAndTranslation.last {

                           let original = String(originalSubstring).trim()
                           let translate = String(translateSubstring).trim()

                            jsonArray.append([HttpKeys.Original : original,
                                           HttpKeys.Translation : translate])
                        }
                    }
                }
//                print(doc.body!)
                    newBody = try jsonArray.enumerated().map { (index, element) in
                        if let jsonObject = element as? JsonObject {
                            return try T.init(from: jsonObject)
                        }
                        else {
                            throw JsonSyntaxError(message: "Failed to convert element of array[\(index)] to JSON object.")
                        }
                    }
            }
            catch {
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

