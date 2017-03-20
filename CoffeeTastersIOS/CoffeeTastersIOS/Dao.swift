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
    var banco:String?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
        
        if type(of: T.self) == type(of: Avaliacao.self) {
            banco = "CDAvaliacao"
        } else if type(of: T.self) == type(of: Cafe.self) {
            banco = "CDCafe"
        } else if type(of: T.self) == type(of: Item.self) {
            banco = "CDItem"
        } else if type(of: T.self) == type(of: Pedido.self) {
            banco = "CDPedido"
        } else if type(of: T.self) == type(of: Produto.self) {
            banco = "CDProduto"
        } else if type(of: T.self) == type(of: Carrinho.self) {
            banco = "CDCarrinho"
        } else if type(of: T.self) == type(of: Flavor.self) {
            banco = "CDFlavor"
        } else if type(of: T.self) == type(of: Passo.self) {
            banco = "CDPasso"
        } else if type(of: T.self) == type(of: Preparo.self) {
            banco = "CDPreparo"
        } else if type(of: T.self) == type(of: Imagens.self) {
            banco = "CDImagens"
        }
        
    }
    
    func new() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: banco!, into: managedContext!) as! T
    }
    
    func list() -> [T] {
        var retorno:[T] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
        
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
