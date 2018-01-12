//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Spencer Goff on 6/17/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    /*sets left bar button item*/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        //let lastRow = tableView.numberOfRows(inSection: 0)
        //let indexPath = IndexPath(row: lastRow, section: 0) //makes new index path (i.e. section and row) for 0th section, last row
        //tableView.insertRows(at: [indexPath], with: .automatic)//NOTE: Must add an item to itemstore before inserting a new row; else error
        
        let newItem = itemStore.createItem() //Must add an item to itemstore before inserting a new row; else inconsistency error
        
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    //not needed after edit button added to navigation bar
    /*@IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing { //if currently in editing mode
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true) //turn off editing mode
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true) //enter editing mode
        }
    }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell //get a new or recycled cell to save memory
        let item = itemStore.allItems[indexPath.row] //sets text on cell to description of item at nth index of "items"
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        if item.valueInDollars >= 50 {
            cell.valueLabel.textColor = UIColor.red
        } else {
            cell.valueLabel.textColor = UIColor.green
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            let title = "Remove \(item.name)?"
            let message = "Are you sure you want to remove this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet) //actionSheet comes from the bottom
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action)-> Void in
                self.itemStore.removeItem(item)
                self.imageStore.deleteImage(forKey: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)

            present(ac, animated: true, completion: nil) //nothing else on the screen can be used until alert is dismissed
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() //this updates data after user changes in detail view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*/* makes sure the content doesn't overlap w. the status bar at top */
        let statusBarHeight = UIApplication.shared.statusBarFrame.height //height of status bar (at top of screen)
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets*/
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65 //default value
        
    }
}


























