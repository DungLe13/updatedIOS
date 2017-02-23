//
//  reviewDetailViewController.swift
//  MapLocator
//
//  Created by Student on 5/22/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class reviewDetailViewController: UIViewController {
    
    @IBOutlet weak var titleDisplay: UILabel!
    
    @IBOutlet weak var starDisplay: CosmosView!
    
    @IBOutlet weak var reviewDisplay: UILabel!
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBOutlet weak var placeDisplay: UILabel!
    
    let ref = Firebase(url: "https://map-locator.firebaseio.com/reviews")
    
    var selectedItem = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadDataFromFirebase()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateImage(_ imageString: String) {
        let decodedData = Data(base64Encoded: imageString, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)
        imageDisplay!.image = decodedImage
    }
    
    // MARK:- Load Data from Firbase
    
    func loadDataFromFirebase() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                
                if self.selectedItem["name"] as? String == dict.objectForKey("name") as? String {
                    
                    self.titleDisplay!.text = dict.objectForKey("titleReview") as? String
                    self.placeDisplay!.text = dict.objectForKey("name") as? String
                    self.starDisplay!.rating = (dict.objectForKey("rating") as? Double)!
                    self.reviewDisplay!.text = dict.objectForKey("userReviews") as? String
                    
                    let base64String = dict.objectForKey("photoBase64") as! String
                    self.populateImage(base64String)

                }
                
            }

            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
}
