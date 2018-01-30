// ----------------------------------------------------------------------------
//
//  BasicRestApiCallback.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import DispatchFramework
import NetworkingApiRest

// ----------------------------------------------------------------------------

class BasicRestApiCallback<Ti, To>: QuietBasicRestApiCallback<Ti, To>
{
// MARK: - Construction

    @discardableResult
    func thenUI(
            initInterface initInterfaceBlock: InitInterfaceBlock? = nil,
            finalize finalizeBlock: FinalizeBlock? = nil
        ) -> Self
    {
        // Init instance variables
        self.initInterfaceBlock = initInterfaceBlock
        self.finalizeBlock = finalizeBlock

        // Done
        return self
    }

// MARK: - Properties

    // ...

// MARK: - Methods

    // ...

// MARK: - Methods: Callbacks

    override func onShouldExecute(_ call: Call<Ti>) -> Bool
    {
        let result = super.onShouldExecute(call)

        // Init UI if needed
        if result {
            initInterface(call)
        }

        return result
    }

    override func onSuccess(_ call: Call<Ti>, entity: ResponseEntity<To>) {
        super.onSuccess(call, entity: entity)

        // Finalize request
        finalize(call, entity: entity)
    }

    override func onFailure(_ call: Call<Ti>, error: RestApiError) {
        super.onFailure(call, error: error)

        // Finalize request
        finalize(call, entity: nil)
    }

    override func onFailureCallback(_ call: Call<Ti>, error: RestApiError) {
        super.onFailureCallback(call, error: error)

        // Show alert view
        AlertViewManager.showErrorAlertView(error)
    }

    override func onCancel(_ call: Call<Ti>) {
        super.onCancel(call)

        // Finalize request
        finalize(call, entity: nil)
    }

// MARK: - Methods: Init interface / Finalize

    func initInterface(_ call: Call<Ti>)
    {
        if let block = self.initInterfaceBlock
        {
            block(call, initInterfaceCallback)
        }
        else {
            initInterfaceCallback(call)
        }
    }

    func initInterfaceCallback(_ call: Call<Ti>)
    {
        // Show new ProgressHUD view

        Dispatch.sync(Queue.main) {
            AlertViewManager.showProgressView(R.string.localizationLabel.hudLoading())
        }
    }

    func finalize(_ call: Call<Ti>, entity: ResponseEntity<To>?)
    {
        if let block = self.finalizeBlock
        {
            block(call, entity, finalizeCallback)
        }
        else {
            finalizeCallback(call, entity: entity)
        }
    }

    func finalizeCallback(_ call: Call<Ti>, entity: ResponseEntity<To>?)
    {
        // Dismiss ProgressHUD view only
        Dispatch.sync(Queue.main) {
            AlertViewManager.dismissProgressView()
        }
    }

// MARK: - Actions

    // ...

// MARK: - Private Methods

    // ...

// MARK: - Inner Types

    typealias InitInterfaceCallback = (Call<Ti>) -> Void
    typealias InitInterfaceBlock = (Call<Ti>, InitInterfaceCallback) -> Void

    typealias FinalizeCallback = (Call<Ti>, ResponseEntity<To>?) -> Void
    typealias FinalizeBlock = (Call<Ti>, ResponseEntity<To>?, FinalizeCallback) -> Void

// MARK: - Constants

    // ...

// MARK: - Variables

    fileprivate var initInterfaceBlock: InitInterfaceBlock?

    fileprivate var finalizeBlock: FinalizeBlock?

}

// ----------------------------------------------------------------------------
