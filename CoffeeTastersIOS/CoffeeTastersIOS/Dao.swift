//
//  Dao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/19/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import CoreData

class Dao<T> {
    
    var managedContext: NSManagedObjectContext?
    var banco:String
    
    init(banco: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
        self.banco = banco
    }
    
    func new() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: banco, into: managedContext!) as! T
    }
    
    func list<T>() -> [T] {
        var retorno:[T] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco)
        
        do {
            retorno = try managedContext?.fetch(fetchRequest) as! [T]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return retorno
    }
    
    func insert(_ obj: NSManagedObject) {
        managedContext?.insert(obj)
    }
    
    func delete(_ obj: NSManagedObject) {
        managedContext?.delete(obj)
    }
    
    func reset () {
        managedContext?.reset()
    }

    func save() {
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Impossível salvar... \(error), \(error.userInfo)")
        }
    }
    
}
