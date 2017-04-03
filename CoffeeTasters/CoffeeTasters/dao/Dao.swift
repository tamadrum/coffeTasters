//
//  Dao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Dao<T> {
    
    var banco:String?
    var managedContext: NSManagedObjectContext!
    
    init() {
        if type(of: T.self) == type(of: Avaliacao.self) {
            banco = "Avaliacao"
        } else if type(of: T.self) == type(of: Cafe.self) {
            banco = "Cafe"
        } else if type(of: T.self) == type(of: Item.self) {
            banco = "Item"
        } else if type(of: T.self) == type(of: Pedido.self) {
            banco = "Pedido"
        } else if type(of: T.self) == type(of: Produto.self) {
            banco = "Produto"
        } else if type(of: T.self) == type(of: Carrinho.self) {
            banco = "Carrinho"
        } else if type(of: T.self) == type(of: Flavor.self) {
            banco = "Flavor"
        } else if type(of: T.self) == type(of: Passo.self) {
            banco = "Passo"
        } else if type(of: T.self) == type(of: Preparo.self) {
            banco = "Preparo"
        } else if type(of: T.self) == type(of: Imagens.self) {
            banco = "Imagens"
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
        
    }
    
    func new() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: banco!,
                                                   into: managedContext) as! T
    }
    
    func list() -> [T] {
        var retorno:[T] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
        
        do {
            retorno = try managedContext.fetch(fetchRequest) as! [T]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return retorno
    }

    func delete(_ obj: NSManagedObject) {
        managedContext.delete(obj)
    }
    
    func reset () {
        managedContext.reset()
    }
    
    func save () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Impossível salvar... \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
