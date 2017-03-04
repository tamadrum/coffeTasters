//
//  FlavorDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/3/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FlavorDao {
    
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func newFlavor() -> Flavor {
        return NSEntityDescription.insertNewObject(forEntityName: "CDFlavor", into: managedContext!) as! Flavor
    }
}
