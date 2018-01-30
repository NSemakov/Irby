// ----------------------------------------------------------------------------
//
//  AlertViewManager.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2015, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import DispatchFramework
import MBProgressHUD
import SwiftCommonsLang
import UIKit

// ----------------------------------------------------------------------------

class AlertViewManager
{
// MARK: - Construction

    static let defaultManager = AlertViewManager()

    fileprivate init() {
        // Do nothing ..
    }

    deinit {
        // Dismiss all active views
        replaceActiveView(nil)
    }

// MARK: - Methods

    class func showAlertView(_ title: String? = nil, message: String? = nil, actionHandler: AlertViewActionHandler? = nil, cancelButtonTitle: String? = nil)
    {
        guard title.isNotEmpty || message.isNotEmpty else {
            Roxie.fatalError("Illegal arguments.")
        }

        let cancelTitle = (cancelButtonTitle == nil) ? R.string.localizationButton.close() : cancelButtonTitle

        let alertView = UIAlertView(title: (title ?? ""), message: (message ?? ""), delegate: actionHandler,
                cancelButtonTitle: cancelTitle)

        self.defaultManager.replaceActiveView(alertView, actionHandler: actionHandler)
    }

    class func showErrorAlertView(_ message: String? = nil, actionHandler: AlertViewActionHandler? = nil, cancelButtonTitle: String? = nil) {
        let cancelTitle = (cancelButtonTitle == nil) ? R.string.localizationButton.close() : cancelButtonTitle

        showAlertView(R.string.localizationAlert.titleError(), message: message, actionHandler: actionHandler, cancelButtonTitle: cancelTitle)
    }

    class func showNotImplementedAlertView(_ actionHandler: AlertViewActionHandler? = nil, cancelButtonTitle: String? = nil) {
        let cancelTitle = (cancelButtonTitle == nil) ? R.string.localizationButton.close() : cancelButtonTitle

        showAlertView(R.string.localizationAlert.workInProgress(), actionHandler: actionHandler, cancelButtonTitle: cancelTitle)
    }

    class func showYesNoAlertView(_ title: String? = nil, message: String? = nil, actionHandler: AlertViewActionHandler? = nil)
    {
        guard title.isNotEmpty || message.isNotEmpty else {
            Roxie.fatalError("Illegal arguments.")
        }

        let alertView = UIAlertView(title: (title ?? ""), message: (message ?? ""), delegate: actionHandler,
                cancelButtonTitle: R.string.localizationButton.no(), otherButtonTitles: R.string.localizationButton.yes())

        self.defaultManager.replaceActiveView(alertView, actionHandler: actionHandler)
    }

    class func showProgressView(_ message: String, actionHandler: ProgressHUDActionHandler? = nil)
    {
        let progressView = MBProgressHUD(frame: UIScreen.main.bounds)

        // Init HUD view
        progressView.delegate = actionHandler
        progressView.minShowTime = 0.2
        progressView.removeFromSuperViewOnHide = true

        progressView.dimBackground = true
        progressView.labelFont = UIFont.boldSystemFont(ofSize: 14.0)
        progressView.labelText = message
        progressView.margin  = 12.0
        progressView.opacity = 0.75

        // Show new ProgressHUD view
        self.defaultManager.replaceActiveView(progressView, actionHandler: actionHandler)
    }

    class func showCustomAlertView(_ alertView: UIAlertView?, actionHandler: AlertViewActionHandler? = nil) {
        self.defaultManager.replaceActiveView(alertView, actionHandler: actionHandler)
    }

// --

    class func dismissAlertView(_ animated: Bool = true) {
        self.defaultManager.dismiss(animated, viewType: .alertView)
    }

    class func dismissProgressView(_ animated: Bool = true) {
        self.defaultManager.dismiss(animated, viewType: .progressView)
    }

    class func dismiss(_ animated: Bool = true) {
        self.defaultManager.dismiss(animated)
    }

// MARK: - Private Methods

    func replaceActiveView(_ view: UIView?, actionHandler: NSObject? = nil)
    {
        weak var weakSelf = self
        Dispatch.sync(Queue.main)
        {
            // Show new AlertView
            if let alertView = view as? UIAlertView, (actionHandler == nil) || (actionHandler is AlertViewActionHandler) {
                weakSelf?.replace(alertView, actionHandler: actionHandler as? AlertViewActionHandler)
            }
            else
            // Show new ProgressHUD view
            if let progressView = view as? MBProgressHUD, (actionHandler == nil) || (actionHandler is ProgressHUDActionHandler) {
                weakSelf?.replace(progressView, actionHandler: actionHandler as? ProgressHUDActionHandler)
            }
            // Dismiss all active views
            else {
                weakSelf?.dismiss(true)
            }
        }
    }

    fileprivate func replace(_ newAlertView: UIAlertView, actionHandler: AlertViewActionHandler?)
    {
        // Dismiss active view
        if self.viewHolder != nil {
            dismiss(false, withDelay: false)
        }

        // Use default handler if user handler is not exists
        let actionHandler = actionHandler ?? AlertViewActionHandler()

        // Save AlertView with action handler
        self.viewHolder = ViewHolder(view: newAlertView, actionHandler: actionHandler)

        // Set delegate to alert view
        newAlertView.delegate = actionHandler

        // Show new AlertView
        newAlertView.show()
    }

    fileprivate func replace(_ newProgressView: MBProgressHUD, actionHandler: ProgressHUDActionHandler?)
    {
        // Update existing ProgressHUD view
        if let progressView = (self.viewHolder?.view as? MBProgressHUD), (progressView.superview != nil)
        {
            // Send message to the delegate
            progressView.delegate?.hudWasHidden?(progressView)

            // Use default handler if user handler is not exists
            let actionHandler = actionHandler ?? ProgressHUDActionHandler()

            // Save ProgressHUD with action handler
            self.viewHolder = ViewHolder(view: progressView, actionHandler: actionHandler)

            // Replace message and delegate
            progressView.labelText = newProgressView.labelText
            progressView.delegate  = actionHandler

            // Show ProgressHUD again, if hide action was delayed
            progressView.show(false)
        }
        else
        {
            // Search for window to add a subview
            let windowForSubview = UIApplication.shared.keyWindow

            // Dismiss active view
            if self.viewHolder != nil {
                dismiss(false, withDelay: false)
            }

            // Use default handler if user handler is not exists
            let actionHandler = actionHandler ?? ProgressHUDActionHandler()

            // Save ProgressHUD with action handler
            self.viewHolder = ViewHolder(view: newProgressView, actionHandler: actionHandler)

            // Set delegate to alert view
            newProgressView.delegate = actionHandler

            // Show new ProgressHUD view
            windowForSubview?.addSubview(newProgressView)
            newProgressView.show(true)
        }
    }

// --

    fileprivate func dismiss(_ animated: Bool, viewType: ViewType? = nil, withDelay: Bool = true)
    {
        weak var weakSelf = self
        Dispatch.sync(Queue.main)
        {
            // Dismiss active AlertView
            if (viewType == nil) || (viewType == .alertView) {
                weakSelf?.dismissAlertView(animated)
            }

            // Dismiss active ProgressHUD view
            if (viewType == nil) || (viewType == .progressView) {
                weakSelf?.dismissProgressView(animated, withDelay: withDelay)
            }
        }
    }

    fileprivate func dismissAlertView(_ animated: Bool)
    {
        if let alertView = (self.viewHolder?.view as? UIAlertView)
        {
            var alertViewDelegate: UIAlertViewDelegate?
            if let delegate = (alertView.delegate as? UIAlertViewDelegate)
            {
                alertViewDelegate = delegate

                // Remove delegate from alert view to prevent async method calls after dismissWithClickedButtonIndex()
                alertView.delegate = nil
            }

            // Send message to the delegate
            alertViewDelegate?.alertView?(alertView, willDismissWithButtonIndex: Inner.AlertViewDismissButtonIndex)

            // Dismiss alert view
            alertView.dismiss(withClickedButtonIndex: Inner.AlertViewDismissButtonIndex, animated: animated)

            // Send message to the delegate
            alertViewDelegate?.alertView?(alertView, didDismissWithButtonIndex: Inner.AlertViewDismissButtonIndex)

            // Release resources
            self.viewHolder = nil
        }
    }

    fileprivate func dismissProgressView(_ animated: Bool, withDelay: Bool)
    {
        if let progressView = (self.viewHolder?.view as? MBProgressHUD)
        {
            if (progressView.superview != nil)
            {
                // Send message to the delegate
                let actionHandler = progressView.delegate as? ProgressHUDActionHandler
                progressView.completionBlock = { [weak self] in
                    actionHandler?.hudWasHidden(progressView)

                    // Release resources
                    if (self?.viewHolder?.view === progressView) {
                        self?.viewHolder = nil
                    }
                }

                // Hide ProgressHUD view
                progressView.removeFromSuperViewOnHide = true
                if withDelay {
                    progressView.hide(animated, afterDelay: Inner.ProgressViewHideDelay)
                } else {
                    progressView.hide(animated)
                }
            }
        }
    }

// MARK: - Inner Types

    struct AlertViewParams
    {
        let title: String?
        let message: String?
    }

// MARK: - Constants

    fileprivate struct Inner
    {
        static let AlertViewDismissButtonIndex = -1
        static let ProgressViewHideDelay: TimeInterval = 0.5
    }

    fileprivate struct ViewHolder {
        let view: UIView
        let actionHandler: NSObject
    }

    fileprivate enum ViewType {
        case alertView
        case progressView
    }

// MARK: - Variables

    fileprivate var viewHolder: ViewHolder?

}

// ----------------------------------------------------------------------------
