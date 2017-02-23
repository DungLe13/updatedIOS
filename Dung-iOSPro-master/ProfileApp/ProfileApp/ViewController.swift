//
//  ViewController.swift
//  ProfileApp
//
//  Created by Student on 3/1/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var followerLabel: UILabel!

    var followerNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.whiteColor().CGColor
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true
        
        followerLabel.text = "Followers: 0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        followerNumber++
        followerLabel.text = "Followers: \(followerNumber)"
    }
    
}

