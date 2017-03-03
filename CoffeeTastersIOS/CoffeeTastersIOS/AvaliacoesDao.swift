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

class AvaliacoesDao {
    
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func getLista() -> Array<Avaliacao> {
        var retorno = Array<Avaliacao>()
        
        var avaliacoes: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CDAvaliacao")
        
        do {
            avaliacoes = try managedContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for obj in avaliacoes {
            let a = Avaliacao()
            
            a.gostou = obj.value(forKeyPath: "gostou") as! Int
            a.cafe = obj.mutableSetValue(forKey: "cafe").allObjects.first as! Cafe
            a.data = obj.value(forKey: "data") as! Date
            a.flavor = obj.mutableSetValue(forKey: "cafe").allObjects.first as! Flavor
            a.flavorMedia = obj.mutableSetValue(forKey: "cafe").allObjects.first as! Flavor
            a.metodoPreparo = obj.value(forKey: "metodoPreparo") as! String
            a.obs = obj.value(forKey: "obs") as! String
            
            retorno.append(a)
        }
        
        return retorno
    }
    
    func save(_ data: Avaliacao) {
        let entity = NSEntityDescription.entity(forEntityName: "CDAvaliacao", in: managedContext!)!
        let avaliacao = NSManagedObject(entity: entity, insertInto: managedContext)
        
        avaliacao.setValue(data.gostou, forKey: "gostou")
        avaliacao.setValue(NSSet(object: data.cafe), forKey: "cafe")
        avaliacao.setValue(data.data, forKeyPath: "data")
        avaliacao.setValue(NSSet(object: data.flavor), forKey: "flavor")
        avaliacao.setValue(NSSet(object: data.flavorMedia), forKey: "flavorMedia")
        avaliacao.setValue(data.metodoPreparo, forKey: "metodoPreparo")
        avaliacao.setValue(data.obs, forKey: "obs")
        
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
