// ----------------------------------------------------------------------------
//
//  AlertViewActionHandler.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2015, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import UIKit

// ----------------------------------------------------------------------------

class AlertViewActionHandler: NSObject
{
// MARK: - Construction

    init(onCancel onCancelBlock: OnCancelBlock? = nil,
         onClickedOtherButton onClickedOtherButtonBlock: OnClickedOtherButtonBlock? = nil,
         onDismiss onDismissBlock: OnDismissBlock? = nil)
    {
        self.onCancelBlock = onCancelBlock
        self.onClickedOtherButtonBlock = onClickedOtherButtonBlock
        self.onDismissBlock = onDismissBlock
    }

// MARK: - Inner Types

    typealias OnCancelBlock = () -> Void
    typealias OnClickedOtherButtonBlock = (_ buttonIndex: Int) -> Void
    typealias OnDismissBlock = () -> Void

// MARK: - Constants

    fileprivate struct Inner {
        static let AlertViewDismissButtonIndex = -1
    }

// MARK: - Variables

    fileprivate var onCancelBlock: OnCancelBlock?
    fileprivate var onClickedOtherButtonBlock: OnClickedOtherButtonBlock?
    fileprivate var onDismissBlock: OnDismissBlock?
    fileprivate var dismissed = false

}

// ----------------------------------------------------------------------------
// MARK: - @protocol UIAlertViewDelegate
// ----------------------------------------------------------------------------

extension AlertViewActionHandler: UIAlertViewDelegate
{
// MARK: - Methods

    func didPresent(_ alertView: UIAlertView)
    {
        // Keyboard pops up after UIAlertView is dismissed on iOS 8.3
        // @link http://stackoverflow.com/questions/30129278/keyboard-pops-up-after-uialertview-is-dismissed-on-ios-8-3-for-ipad

        // Keyboard will appeared automatically in ios 8.3 while displaying alertview
        // @link http://stackoverflow.com/questions/30498972/keyboard-will-appeared-automatically-in-ios-8-3-while-displaying-alertview-or-al

        // Hide software keyboard
        UIApplication.shared.keyWindow?.endEditing(true)
    }

    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int)
    {
        if !self.dismissed {
            self.dismissed = true

            if (buttonIndex == alertView.cancelButtonIndex)
            {
                if let cancelBlock = self.onCancelBlock {
                    cancelBlock()
                }
            }
            else
            if (buttonIndex != Inner.AlertViewDismissButtonIndex)
            {
                if let clickedOtherButtonBlock = self.onClickedOtherButtonBlock {
                    clickedOtherButtonBlock(buttonIndex)
                }
            }

            if let dismissBlock = self.onDismissBlock {
                dismissBlock()
            }
        }
    }

}

// ----------------------------------------------------------------------------
