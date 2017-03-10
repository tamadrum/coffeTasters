//
//  PreparaDao.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 03/03/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PreparaDao {
    
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func newPreparo() -> Preparo {
        return NSEntityDescription.insertNewObject(forEntityName: "CDPreparo", into: managedContext!) as! Preparo
    }
    
    func newPasso() -> Passo {
        return NSEntityDescription.insertNewObject(forEntityName: "CDPasso", into: managedContext!) as! Passo
    }
    
    func getPreparo() -> [Preparo] {
        /// Inicio do preparo1
        let preparo1 = newPreparo()
        preparo1.nome = "Coado"
        preparo1.imagem = "coffee_press_1.png"
        
        let passo1 = newPasso()
        passo1.indice = 1
        passo1.tempo = 5
        passo1.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo1.descricao = "Moer os grãos"
        preparo1.addToPasso(passo1)

        let passo2 = newPasso()
        passo2.indice = 2
        passo2.tempo = 5
        passo2.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo2.descricao = "Colocar o pó no coador"
        preparo1.addToPasso(passo2)
        
        let passo3 = newPasso()
        passo3.indice = 3
        passo3.tempo = 5
        passo3.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo3.descricao = "Jogar agua e esperar"
        preparo1.addToPasso(passo3)
            
        let passo4 = newPasso()
        passo4.indice = 4
        passo4.tempo = 5
        passo4.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo4.descricao = "Colocar na garrafa térmica"
        preparo1.addToPasso(passo1)
        
        /// Inicio do preparo2
        let preparo2 = newPreparo()
        preparo2.nome = "Prensa Francesa"
        preparo2.imagem = "pour_over_cone_1.png"
        
        let passo5 = newPasso()
        passo5.indice = 1
        passo5.tempo = 5
        passo5.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo5.descricao = "Moer os grãos"
        preparo2.addToPasso(passo5)
        
        let passo6 = newPasso()
        passo6.indice = 2
        passo6.tempo = 5
        passo6.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo6.descricao = "Colocar o pó no coador"
        preparo2.addToPasso(passo6)
        
        let passo7 = newPasso()
        passo7.indice = 3
        passo7.tempo = 5
        passo7.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo7.descricao = "Jogar agua e esperar"
        preparo2.addToPasso(passo7)
        
        let passo8 = newPasso()
        passo8.indice = 4
        passo8.tempo = 5
        passo8.addToImagens(NSSet(array:["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]))
        passo8.descricao = "Colocar na garrafa térmica"
        preparo2.addToPasso(passo8)
     
        return [preparo1, preparo2]
    }

}
