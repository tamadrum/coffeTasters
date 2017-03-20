//
//  AvaliacoesDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AvaliacoesDao:Dao<Avaliacao> {
    
    convenience init() {
        self.init(banco: "CDAvaliacao")
    }
    
//    var managedContext: NSManagedObjectContext?
//    
//    init() {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            managedContext = appDelegate.persistentContainer.viewContext
//        }
//    }
//    
//    func getLista() -> [Avaliacao] {
//        var retorno:[Avaliacao] = []
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDAvaliacao")
//        
//        do {
//            retorno = try managedContext?.fetch(fetchRequest) as! [Avaliacao]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//        return retorno
//    }
//    
//    func newAvaliacao() -> Avaliacao {
//        return NSEntityDescription.insertNewObject(forEntityName: "CDAvaliacao", into: managedContext!) as! Avaliacao
//    }
//
//    func save() {
//        do {
//            try managedContext?.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
//    
//    func delete(_ avaliacao: Avaliacao) {
//        managedContext?.delete(avaliacao.flavor!)
//        managedContext?.delete(avaliacao.flavorMedia!)
//        managedContext?.delete(avaliacao)
//        save()
//    }
    
}
