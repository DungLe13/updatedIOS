//
//  TimeZoneDataTableViewController.swift
//  myClockApp
//
//  Created by Student on 3/14/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import Foundation

class TimeZoneDataTableViewController: UITableViewController {
    
    var timeZoneData = NSTimeZone.knownTimeZoneNames()
    let now = NSDate()
    let currentCalendar = NSCalendar.currentCalendar()
    
    var viewController: ViewController?
    
    //let dateFormat = NSDateFormatter()
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZoneData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeZoneCell", forIndexPath: indexPath)

        cell.textLabel?.text = timeZoneData[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        viewController!.timeZoneData.append("timeZoneName")
        
        if((self.presentingViewController) != nil) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func cancel(sender: AnyObject) {
        if((self.presentingViewController) != nil) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
