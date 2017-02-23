//
//  ViewController.swift
//  myClockApp
//
//  Created by Student on 3/14/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    
    var displayedClock: Int!
    var timeZoneData = NSTimeZone.knownTimeZoneNames()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem =  editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("clockCell", forIndexPath: indexPath) as! clockCell
        
        cell.DisplayTime.text = currentTime(timeZoneData.first!)//
        cell.DisplayLocation.text = timeZoneData.first
        cell.DisplayDate.text = currentDate(timeZoneData.first!)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pickTimeZoneSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let timeZoneViewController = navigationController.topViewController as! TimeZoneDataTableViewController
            timeZoneViewController.viewController = self
        }
    }
    
    func currentTime(timeZoneName: String) -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.timeZone = NSTimeZone(name: timeZoneName)!
        
        dateFormat.timeStyle = .ShortStyle
        
        return dateFormat.stringFromDate(NSDate())
    }
    
    func currentDate(timeZoneName: String) -> String {
        let dateFormat = NSDateFormatter()
        dateFormat.timeZone = NSTimeZone(name: timeZoneName)!

        dateFormat.dateStyle = .LongStyle
        
        return dateFormat.stringFromDate(NSDate())
    }
}