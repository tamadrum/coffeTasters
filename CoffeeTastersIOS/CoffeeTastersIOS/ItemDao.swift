//
//  ItemDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/10/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ItemDao {
    
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func newItem() -> Item {
        return NSEntityDescription.insertNewObject(forEntityName: "CDItem", into: managedContext!) as! Item
    }
}
