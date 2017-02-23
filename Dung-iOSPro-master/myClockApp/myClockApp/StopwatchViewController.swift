//
//  StopwatchViewController.swift
//  myClockApp
//
//  Created by Student on 3/17/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import Foundation

class StopwatchViewController: UIViewController {
    
    @IBOutlet var SSButton: UIButton!
    @IBOutlet var currentTimeLabel: UILabel!

    @IBOutlet var lapRecordLabel: UIButton!
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SSButton.layer.borderWidth = 1
        SSButton.layer.masksToBounds = false
        SSButton.layer.borderColor = UIColor.grayColor().CGColor
        SSButton.layer.cornerRadius = SSButton.frame.size.width/2
        SSButton.clipsToBounds = true
        
        lapRecordLabel.layer.borderWidth = 1
        lapRecordLabel.layer.masksToBounds = false
        lapRecordLabel.layer.borderColor = UIColor.grayColor().CGColor
        lapRecordLabel.layer.cornerRadius = SSButton.frame.size.width/2
        lapRecordLabel.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        currentTimeLabel.text = "\(strMinutes):\(strSeconds).\(strFraction)"
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        if timer.valid {
            SSButton.setTitle("Start", forState: .Normal)
            
            timer.invalidate()
        }
        
        else {
            SSButton.setTitle("Stop", forState: .Normal)
            
            let aSelector: Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
}
