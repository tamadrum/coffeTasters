//
//  ProdutoDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProdutoDao {
    
    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func newProduto() -> Produto {
        return NSEntityDescription.insertNewObject(forEntityName: "CDProduto", into: managedContext!) as! Produto
    }
    
    func getProdutos (comOferta: Bool) -> Array<Produto> {
        var produtos = Array<Produto>()
        
        let prod1 = newProduto()
        prod1.nome = "Café Pelé"
        prod1.preco = 10
        prod1.tipo = "Café"
        prod1.oferta = true
        prod1.precoOferta = 9
        prod1.descricao = "Descrição do Café"
        
        let prod2 = newProduto()
        prod2.nome = "Café Pilão"
        prod2.preco = 20
        prod2.tipo = "Café"
        prod2.oferta = false
        prod2.descricao = "Descrição do Café"
        
        let prod3 = newProduto()
        prod3.nome = "3 Corações"
        prod3.preco = 30
        prod3.tipo = "Café"
        prod3.oferta = false
        prod3.descricao = "Descrição do Café"
        
        produtos.append(prod1)
        produtos.append(prod2)
        produtos.append(prod3)
        
        if ( comOferta ) {
            return produtos.filter({ (produto) -> Bool in
                return produto.oferta
            })
        }
        return produtos.filter({ (produto) -> Bool in
            return !produto.oferta
        })
    }
    
}
