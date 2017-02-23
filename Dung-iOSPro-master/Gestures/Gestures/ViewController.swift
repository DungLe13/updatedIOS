//
//  ViewController.swift
//  Gestures
//
//  Created by Justin Vasselli on 5/16/16.
//  Copyright © 2016 Justin Vasselli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gestureLabel: UILabel!
    
    @IBOutlet var singleTapRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        singleTapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func singleTap(sender: AnyObject) {
        showGestureName("Tap")
    }
    
    @IBAction func doubleTap(sender: AnyObject) {
        showGestureName("Double Tap")
    }
    
    @IBAction func pinch(sender: UIPinchGestureRecognizer) {
        if sender.state == .Ended {
            let direction = (sender.velocity < 0) ? "In" : "Out"
            showGestureName("Pinch \(direction)")
        }
    }
    
    @IBAction func rotate(sender: UIRotationGestureRecognizer) {
        if sender.state == .Ended {
            showGestureName("Rotation")
        }
    }
    
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            switch sender.direction {
            case UISwipeGestureRecognizerDirection.Right:
                showGestureName("Swipe Right")
            case UISwipeGestureRecognizerDirection.Left:
                showGestureName("Swipe Left")
            case UISwipeGestureRecognizerDirection.Up:
                showGestureName("Swipe Up")
            case UISwipeGestureRecognizerDirection.Down:
                showGestureName("Swipe Down")
            default:
                break
            }
        }
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        showGestureName("Shake")
    }
    
    func showGestureName(name: String) {
        gestureLabel.text = name
        UIView.animateWithDuration(1.0, animations: fadeTextIn, completion: fadeTextOut)
    }
    
    func fadeTextIn() {
        gestureLabel.alpha = 1.0
    }
    
    func fadeTextOut(completion: Bool) {
        UIView.animateWithDuration(1.0) {
            self.gestureLabel.alpha = 0.0
        }
    }
}

