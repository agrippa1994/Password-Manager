//
//  AddServerEntryTableViewController.swift
//  Password-Manager
//
//  Created by Mani on 15.12.14.
//  Copyright (c) 2014 Mani. All rights reserved.
//

import UIKit

@objc protocol AddServerEntryTableViewControllerDelegate
{
    func didEnteredServerEntry(server: String, email: String)
    optional func didCancelAddServerEntry()
}

class AddServerEntryTableViewController: UITableViewController {

    weak var delegate: AddServerEntryTableViewControllerDelegate?
    
    @IBOutlet var serverTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.didCancelAddServerEntry?()
    }

    @IBAction func onSave(sender: UIBarButtonItem) {
        if serverTextField.text.isEmpty || emailTextField.text.isEmpty {
            UIAlertView(title: Localized("ALERTVIEW_ERROR_TITLE"), message: Localized("INVALID_SERVER_OR_EMAIL"), delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.didEnteredServerEntry(serverTextField.text, email: emailTextField.text)
    }
}
