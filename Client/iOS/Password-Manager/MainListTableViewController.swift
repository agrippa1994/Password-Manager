//
//  MainListTableViewController.swift
//  Password-Manager
//
//  Created by Mani on 03.01.15.
//  Copyright (c) 2015 Mani. All rights reserved.
//

import UIKit

@objc protocol MainListTableViewControllerDataSource {
    func mainListTableViewControllerServer(mainList: MainListTableViewController) -> String
    func mainListTableViewControllerMail(mainList: MainListTableViewController) -> String
    func mainListTableViewControllerAccountPassword(mainList: MainListTableViewController) -> String
    func mainListTableViewControllerPasswordPassword(mainList: MainListTableViewController) -> String
}

@objc protocol MainListTableViewControllerDelegate {
    optional func mainListTableViewControllerDidCancel(mainList: MainListTableViewController)
}

class MainListTableViewController: UITableViewController, SRWebSocketDelegate {
    weak var delegate: MainListTableViewControllerDelegate?
    weak var dataSource: MainListTableViewControllerDataSource?
    
    private var server: String?
    private var mail: String?
    private var accountPassword: String?
    private var passwordPassword: String?
    
    private var webSocket: SRWebSocket?
    
    @IBOutlet private var passwordsCell: UITableViewCell!
    @IBOutlet private var creditCardCell: UITableViewCell!
    @IBOutlet private var bankAccountCell: UITableViewCell!
    @IBOutlet private var cells: [UITableViewCell]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable cells
        cells.each { $0.hidden = true }
        
        server = dataSource?.mainListTableViewControllerServer(self)
        mail = dataSource?.mainListTableViewControllerMail(self)
        accountPassword = dataSource?.mainListTableViewControllerAccountPassword(self)
        passwordPassword = dataSource?.mainListTableViewControllerPasswordPassword(self)
    
        if server == nil || mail == nil || accountPassword == nil || passwordPassword == nil {
            
        } else {
            webSocket = SRWebSocket(URL: NSURL(string: server!))
        }
    }


    @IBAction func onClose(sender: AnyObject) {
        if delegate?.mainListTableViewControllerDidCancel?(self) == nil {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // Delegations
    func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        
    }
}
