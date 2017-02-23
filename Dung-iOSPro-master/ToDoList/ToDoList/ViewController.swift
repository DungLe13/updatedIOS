//
//  ViewController.swift
//  ToDoList
//
//  Created by Student on 3/21/16.
//  Copyright © 2016 DungLe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var toDoItems = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ToDoItem")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            toDoItems = results as! [NSManagedObject]
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("toDoCell")
        
        cell?.textLabel?.text = toDoItems[indexPath.row].valueForKey("name") as? String
        return cell!
    }

    @IBAction func addNewToDo(sender: AnyObject) {
        let alert = UIAlertController(title: "New Item", message: "What do you need to do?", preferredStyle: .Alert)
        
        let save = UIAlertAction(title: "Save", style: .Default) {
            (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields!.first
            
            //Manage our NSManagedObject
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            let entity = NSEntityDescription.entityForName("ToDoItem", inManagedObjectContext: managedContext)
            let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            item.setValue(textField!.text, forKey: "name")
            
            self.toDoItems.append(item)
            
            //try! managedContext.save()
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print(error.description)
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextFieldWithConfigurationHandler() {
            (UITextField) -> Void in
        }
            
        alert.addAction(save)
            
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

}

