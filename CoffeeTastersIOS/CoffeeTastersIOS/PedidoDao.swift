//
//  PedidoDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PedidoDao:Dao<Pedido> {
    
    convenience init() {
        self.init(banco: "CDPedido")
    }
    
    func getListaPedidos () -> [Pedido] {
        
        let itemDao = Dao<Item>(banco: "CDItem")
        
        var pedidos:[Pedido] = []
        
        let ped1 = new()
        ped1.numero = 101010
        ped1.status = "Em processamento..."
        ped1.valorTotal = 100
 
        let item1 = itemDao.new()
        item1.quantidade = 2
        item1.produto = ProdutoDao().new()
        item1.produto?.nome = "Café Pelé"
        item1.produto?.preco = 10
        item1.produto?.tipo = "Café"
        item1.produto?.oferta = true
        item1.produto?.precoOferta = 9
        item1.produto?.descricao = "Descrição do Café"
        
        let item2 = itemDao.new()
        item2.quantidade = 3
        item2.produto = ProdutoDao().new()
        item2.produto?.nome = "Café Pilão"
        item2.produto?.preco = 20
        item2.produto?.tipo = "Café"
        item2.produto?.oferta = false
        item2.produto?.descricao = "Descrição do Café"
        
        ped1.addToItems(item1)
        ped1.addToItems(item2)
        
        pedidos.append(ped1)
        
        let ped2 = new()
        ped2.numero = 202020
        ped2.status = "Em processamento..."
        ped2.valorTotal = 100
        ped2.items = NSSet()
        
        let item3 = itemDao.new()
        item3.quantidade = 2
        item3.produto = ProdutoDao().new()
        item3.produto?.nome = "Café 3 Corações"
        item3.produto?.preco = 20
        item3.produto?.tipo = "Café"
        item3.produto?.oferta = false
        item3.produto?.precoOferta = 9
        item3.produto?.descricao = "Descrição do Café"
        
        let item4 = itemDao.new()
        item4.quantidade = 3
        item4.produto = ProdutoDao().new()
        item4.produto?.nome = "Café Illy"
        item4.produto?.preco = 50
        item4.produto?.tipo = "Café"
        item4.produto?.oferta = false
        item4.produto?.descricao = "Descrição do Café"
        
        ped2.addToItems(item3)
        ped2.addToItems(item4)

        pedidos.append(ped2)
        
        return pedidos
    }
    
}
