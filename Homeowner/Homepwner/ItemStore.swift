//
//  ItemStore.swift
//  Homepwner
//
//  Created by Spencer Goff on 6/17/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit

//ItemsViewController will call a method on ItemStore when it wants an item to be created, removed, or moved

class ItemStore { //note: this is a Swift base class since it doens't inherit from anything
    var allItems = [Item]()
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    @discardableResult func createItem() -> Item { //the result of this function can be ignored by the caller
        let newItem = Item(random: true) //creates a new item with random property values
        allItems.append(newItem)
        return newItem
    }
    
    /*init() { //unnecessary since the user can add rows as needed
        for _ in 0..<5 { //run 5 times
            createItem()
        }
    }*/
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
    /*Saves every item in allItems to itemArchiveURL (when called in AppDelegate) */
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    init() {
        /*Initialize allItems to anything archived already*/
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
}















