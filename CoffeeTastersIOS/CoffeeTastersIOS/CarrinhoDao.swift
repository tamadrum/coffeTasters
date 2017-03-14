//
//  CarrinhoDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/10/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CarrinhoDao {
    
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func getCarrinho () -> Carrinho {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "CDCarrinho", in: managedContext!)
        
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedContext?.fetch(fetchRequest)
            if ( (result?.count)! > 0 ) {
                let carrinho = result?[0] as! Carrinho
                return carrinho
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return NSEntityDescription.insertNewObject(forEntityName: "CDCarrinho", into: managedContext!) as! Carrinho
    }
    
    func removeItem(_ item: Item) {
        managedContext?.delete(item)
    }
    
    func save() {
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
