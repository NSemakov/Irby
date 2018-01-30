// ----------------------------------------------------------------------------
//
//  GeocodeTask.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Foundation
import NetworkingApiConverters
import NetworkingApiHttp
import NetworkingApiRest
import SwiftCommonsDiagnostics
import IrbyCoreEntities

// ----------------------------------------------------------------------------

open class AmalgamaSongTask: AbstractTask<VoidBody, [TextElementModel]>
{
// MARK: - Construction

    init(builder: AmalgamaSongTaskBuilder)
    {
        // Init instance variables
        self.options = builder.options

        // Parent processing
        super.init(builder: builder)
    }

// MARK: - Methods

    override open func callExecute() -> HttpResult
    {
        let route = RestApiRoute.song(getRequestEntity().url!, title: self.options.title, artist: self.options.artist)
        return newClient().get(newRequestEntity(route))
    }

    override open func onSuccess(_ httpResult: CallResult<Data>) -> CallResult<[TextElementModel]> {
        return AmalgamaSongTask.Converter.convert(httpResult)
    }

    override open func newBuilder() -> AmalgamaSongTaskBuilder {
        return AmalgamaSongTaskBuilder(task: self)
    }

// MARK: - Inner Types

    fileprivate struct Options
    {
        var title: String!
        var artist: String!
    }

// MARK: - Constants

    fileprivate static let Converter = ValidatableHTMLModelArrayConverter<TextElementModel>()

// MARK: - Variables

    fileprivate let options: Options

}

// ----------------------------------------------------------------------------

open class AmalgamaSongTaskBuilder: AbstractTaskBuilder<VoidBody, [TextElementModel]>
{
// MARK: - Construction

    public override init() {
        super.init()
    }

    public init(task: AmalgamaSongTask)
    {
        // Init instance variables
        self.options = task.options

        // Parent processing
        super.init(task: task)
    }

// MARK: - Methods

    override open func checkInvalidState() {
        super.checkInvalidState()

        Guard.notNil(self.options.title)
        Guard.notNil(self.options.artist)
    }

    override open func newTask() -> AmalgamaSongTask {
        return AmalgamaSongTask(builder: self)
    }

    open func title(_ title: String) -> Self {
        self.options.title = title
        return self
    }

    open func artist(_ artist: String) -> Self {
        self.options.artist = artist
        return self
    }

// MARK: - Variables

    fileprivate var options = AmalgamaSongTask.Options()

}

// ----------------------------------------------------------------------------

