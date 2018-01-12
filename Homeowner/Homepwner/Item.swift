//
//  Item.swift
//  Homepwner
//
//  Created by Spencer Goff on 6/17/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String? //optional since an item might not have a serial number
    let dateCreated: Date
    let itemKey: String
    
    //Note: since none of the class attributes have default properties, need to give values in a designated initializer;
    //every class has at least one designated initializer; ensures that every property has a value
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name //must use 'self' since property names are same as argument names
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        super.init() //initializes any super class properties
    }
    
    //convenience initializers are optional
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            var idx  = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100)) //random int 0-99
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName,
                      serialNumber: randomSerialNumber,
                      valueInDollars: randomValue)
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        
        /*gets previously edited object attributes from memory*/
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as? String
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        
    }
    
}
















