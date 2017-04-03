//
//  CarrinhoDao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CarrinhoDao: Dao<Carrinho> {
    
    func getCarrinho () -> Carrinho {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entityDescription = NSEntityDescription.entity(forEntityName: banco!, in: managedContext)
        
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if ( (result.count) > 0 ) {
                let carrinho = result[0] as! Carrinho
                return carrinho
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return NSEntityDescription.insertNewObject(forEntityName: banco!, into: managedContext) as! Carrinho
    }
    
    func getValorCarrinho() -> Double {
        var total = 0.0
        
        let carrinho = getCarrinho()
        
        for item in carrinho.itens! {
            let i = item as! Item
            total += (i.produto?.preco)! * Double(i.quantidade)
        }
        
        return total
    }
    
    func zeraCarrinho() {
        let carrinho = getCarrinho()
        let itemDao = Dao<Item>()
        
        for item in carrinho.itens! {
            carrinho.removeFromItens(item as! Item)
            itemDao.delete(item as! NSManagedObject)
        }
    }
    
}
