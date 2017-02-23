//
//  TypesTableViewController.swift
//  MapLocator
//
//  Created by Student on 5/1/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit

protocol TypesTableViewControllerDelegate: class {
    func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String])
}

class TypesTableViewController: UITableViewController {
    
    let possibleTypesDictionary = ["bakery":"Bakery", "bar":"Bar", "cafe":"Cafe", "grocery_or_supermarket":"Supermarket", "restaurant":"Restaurant"]
    var selectedTypes: [String] = []
    weak var delegate: TypesTableViewControllerDelegate!
    
    var sortedKeys: [String] {
        return possibleTypesDictionary.keys.sorted()
    }

    @IBAction func donePressed(_ sender: AnyObject) {
        delegate?.typesController(self, didSelectTypes: selectedTypes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possibleTypesDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        let key = sortedKeys[indexPath.row]
        let type = possibleTypesDictionary[key]!
        cell.textLabel?.text = type
        cell.imageView?.image = UIImage(named: key)
        cell.accessoryType = (selectedTypes).contains(key) ? .checkmark : .none
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sortedKeys[indexPath.row]
        if (selectedTypes).contains(key) {
            selectedTypes = selectedTypes.filter({$0 != key})
        } else {
            selectedTypes.append(key)
        }
        
        tableView.reloadData()
    }

}


