//: [Previous](@previous)
//:
//: # UITableView
//: One of the most used UI elements.  It's not quite as straightforward as a label or button, so let's go over it!  First, you'll need `UIKit` to use `UITableView`

import Foundation
import UIKit

//:
//: ## UITableViewController
//: `UITableView`s live inside controllers, and as is the case with most `UIView`s, you'll want to make a subclass of the `UIViewController`.
//: `UITableViewController`s need to implement two functions to make the `UITableView` work:
//: 1) `tableView(_:numberOfRowsInSection:)` which should return the number of rows in the section, or number of rows in total if you only have one section
//: 2) `tableView(_:cellForRowAtIndexPath:)` which takes in an `NSIndexPath` that describes where the table cell is and return a `UITableViewCell`.  The setup of this `UITableViewCell` should be done in this method.
//: `NSIndexPath` has a `.section` which is the section index, and a `.row` which is the row index.

class SimpleTableViewController : UITableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.textLabel?.text = "Cell \(indexPath.section).\(indexPath.row)"
        return cell
    }
}

let tableViewController = SimpleTableViewController(style: UITableViewStyle.Plain)
tableViewController.tableView.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

//: ## Multiple sections
//: `UITableViewController`s with multiple sections will need to include at least two more methods:
//: 1) `numberOfSectionsInTableView(_:)` which returns the number of sections in total
//: 2) `tableView(_:titleForHeaderInSection)` which will make the section sepators with the returned String as the label.
//: You may also chose to implement `sectionIndexTitlesForTableView(_:)`, which will create the index on the right side of the screen.  This is often used in long lists, with the sections titled A-#

class MultiSectionTableViewController : UITableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        cell.textLabel?.text = "Cell \(indexPath.section).\(indexPath.row)"
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}

let multiSectionTableViewController = MultiSectionTableViewController(style: UITableViewStyle.Plain)
multiSectionTableViewController.tableView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

//: > **Experiment** make a table that lists 5-10 of your favorite foods, with category sections.
//: > **Hint** Use an array to hold the names of food in a category, and use indexPath.row as the index into the array
//:
//: There are four types of cell styles.  See below for a sample of each of them.

class CellSampleTableViewController : UITableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        switch (indexPath.row) {
        case 0:
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.textLabel?.text = "Default"
        case 1:
            cell = UITableViewCell(style: .Value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Value1"
        case 2:
            cell = UITableViewCell(style: .Value2, reuseIdentifier: nil)
            cell.textLabel?.text = "Value2"
        default:
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = "Subtitle"
        }
        cell.detailTextLabel?.text = "Detail"
        return cell
    }
}

let cellSampleTableViewController = CellSampleTableViewController(style: UITableViewStyle.Plain)
cellSampleTableViewController.tableView.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

//: ## Custom cells
//: You can make your own cells.  It's especially easy to do in Interface Builder, so we'll cover it in class.
//: You'll subclass `UITableViewCell` and set it up in Interface Builder.
//:
//: > **Practice:** Make a table with "New York" and "Tokyo" as the cell titles, and the current time in those cities as the detail text.  `Use UITableViewCellStyle.Value1`


//: [Next](@next)
