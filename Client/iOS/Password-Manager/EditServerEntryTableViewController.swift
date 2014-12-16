//
//  EditServerEntryTableViewController.swift
//  Password-Manager
//
//  Created by Mani on 16.12.14.
//  Copyright (c) 2014 Mani. All rights reserved.
//

import UIKit

@objc protocol EditServerEntryTableViewControllerDelegate
{
    func didEditServerEntry(sender: AnyObject?, server: String, email: String)
    optional func didCancelEditServerEntry()
}

class EditServerEntryTableViewController: UITableViewController {

    weak var delegate: EditServerEntryTableViewControllerDelegate?
    
    var serverText: String?
    var emailText: String?
    weak var sender: AnyObject?
    
    @IBOutlet var serverTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.didCancelEditServerEntry?()
    }
    
    @IBAction func onSave(sender: AnyObject) {
        if serverTextField.text.isEmpty || emailTextField.text.isEmpty {
            UIAlertView(title: Localized("ALERTVIEW_ERROR_TITLE"), message: Localized("INVALID_SERVER_OR_EMAIL"), delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.didEditServerEntry(self.sender, server: serverTextField.text, email: emailTextField.text)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if serverText != nil {
            serverTextField.text = serverText!
        }
        
        if emailText != nil {
            emailTextField.text = emailText!
        }
    }
}
