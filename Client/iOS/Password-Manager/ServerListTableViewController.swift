//
//  ServerListTableViewController.swift
//  Password-Manager
//
//  Created by Mani on 15.12.14.
//  Copyright (c) 2014 Mani. All rights reserved.
//

import UIKit

class ServerListTableViewController: UITableViewController, AddServerEntryTableViewControllerDelegate, EditServerEntryTableViewControllerDelegate {

     var serverEntries: [(String, String)] {
        get {
            var entryData = [(String, String)]()
            
            if let entries = NSUserDefaults.standardUserDefaults().objectForKey("ServerEntries") as? NSArray {
                for objectEntry in entries {
                    if let entry = objectEntry as? NSDictionary {
                        let server = entry["Server"] as? String
                        let email = entry["Email"] as? String
                        
                        if server != nil && email != nil {
                            entryData.append((server!, email!))
                        }
                    }
                }
            }
            return entryData
        }
        
        set(newValue) {
            var entries = [[String : String]]()
            for value in newValue {
                entries.append(["Server" : value.0, "Email" : value.1])
            }
            
            NSUserDefaults.standardUserDefaults().setObject(entries, forKey: "ServerEntries")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.allowsSelectionDuringEditing = true
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverEntries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ServerEntry", forIndexPath: indexPath) as UITableViewCell
        
        let entry = serverEntries[indexPath.row]
        cell.textLabel!.text = entry.0
        cell.detailTextLabel!.text = entry.1
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            serverEntries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if self.tableView.editing {
            self.performSegueWithIdentifier("EditServerEntry", sender: tableView.cellForRowAtIndexPath(indexPath))
        }
    }
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var entry = serverEntries[fromIndexPath.row]
        
        serverEntries.removeAtIndex(fromIndexPath.row)
        serverEntries.insert(entry, atIndex: toIndexPath.row)
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddServerEntry" {
            ((segue.destinationViewController as UINavigationController).topViewController as AddServerEntryTableViewController).delegate = self
        }
        
        if segue.identifier == "EditServerEntry" {
            if let cell = sender as? UITableViewCell {
                let vc = ((segue.destinationViewController as UINavigationController).topViewController as EditServerEntryTableViewController)
                vc.delegate = self
                vc.serverText = cell.textLabel?.text
                vc.emailText = cell.detailTextLabel?.text
                vc.sender = cell
            }
        }
        
        if segue.identifier == "MainList" {
            
        }
    }
    
    func didEnteredServerEntry(server: String, email: String) {
        serverEntries.append((server, email))
        tableView.reloadData()
    }

    func didEditServerEntry(sender: AnyObject?, server: String, email: String) {
        if let cell = sender as? UITableViewCell {
            let idx = self.tableView.indexPathForCell(cell)!.row
            
            serverEntries[idx].0 = server
            serverEntries[idx].1 = email
            
            self.tableView.reloadData()
        }
    }
}
