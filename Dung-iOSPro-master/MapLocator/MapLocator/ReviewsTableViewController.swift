//
//  ReviewsTableViewController.swift
//  MapLocator
//
//  Created by Student on 5/8/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import Firebase

class ReviewsTableViewController: UITableViewController {
    
    let ref = Firebase(url: "https://map-locator.firebaseio.com/reviews")
    var items = [NSDictionary]()
    
    var selectedItem: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        items = [NSDictionary]()
        
        loadDataFromFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! reviewsViewCell

        // Configure the cell...
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = indexPath.row
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "review place" {
            let controller = segue.destination as! reviewDetailViewController
            controller.selectedItem = items[selectedItem]
        }
    }
    
    // MARK:- Configure Cell
    
    func configureCell(_ cell: reviewsViewCell, indexPath: IndexPath) {
        let dict = items[indexPath.row]
        
        cell.placeTitle?.text = dict["name"] as? String
        cell.categorySubtitle?.text = dict["categories"] as? String
        cell.starsDisplay?.rating = dict["rating"] as! Double
        
        let base64String = dict["photoBase64"] as! String
        populateImage(cell, imageString: base64String)
    }
    
    func populateImage(_ cell: reviewsViewCell, imageString: String) {
        let decodedData = Data(base64Encoded: imageString, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        
        let decodedImage = UIImage(data: decodedData!)
        
        cell.imageView!.image = decodedImage
    }
    
    // MARK:- Load Data from Firbase
    
    func loadDataFromFirebase() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            var tempItems = [NSDictionary]()
            
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            
            self.items = tempItems
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

}
