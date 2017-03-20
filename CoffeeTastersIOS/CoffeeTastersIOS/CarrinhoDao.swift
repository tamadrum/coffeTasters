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

class CarrinhoDao:Dao<Carrinho> {

    func getCarrinho () -> Carrinho {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: banco!, in: managedContext!)
        
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
        return NSEntityDescription.insertNewObject(forEntityName: banco!, into: managedContext!) as! Carrinho
    }

}
