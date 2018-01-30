// ----------------------------------------------------------------------------
//
//  RelationTaskProtocol.swift
//
//  @author     Nikita Semakov <SemakovNV@ekassir.com>
//  @copyright  Copyright (c) 2017, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

public protocol RelationTaskProtocol: class
{
// MARK: - Methods

    func taskShouldSuppress(anotherTask: RelationTaskProtocol) -> Bool

}

// ----------------------------------------------------------------------------
