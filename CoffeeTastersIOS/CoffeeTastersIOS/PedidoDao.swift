//
//  PedidoDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

class PedidoDao {
    
    func getListaPedidos () -> [Pedido] {
        var pedidos:[Pedido] = []
        
        let ped1 = Pedido()
        ped1.numero = 101010
        ped1.status = "Em processamento..."
        ped1.valorTotal = 100
        ped1.items = NSSet()
        
        let item1 = Item()
        item1.quantidade = 2
        item1.produto = Produto()
        item1.produto?.nome = "Café Pelé"
        item1.produto?.preco = 10
        item1.produto?.tipo = "Café"
        item1.produto?.oferta = true
        item1.produto?.precoOferta = 9
        item1.produto?.descricao = "Descrição do Café"
        
        let item2 = Item()
        item2.quantidade = 3
        item2.produto = Produto()
        item2.produto?.nome = "Café Pilão"
        item2.produto?.preco = 20
        item2.produto?.tipo = "Café"
        item2.produto?.oferta = false
        item2.produto?.descricao = "Descrição do Café"
        
        ped1.items?.adding(item1)
        ped1.items?.adding(item2)
        
        pedidos.append(ped1)
        
        let ped2 = Pedido()
        ped2.numero = 202020
        ped2.status = "Em processamento..."
        ped2.valorTotal = 100
        ped2.items = NSSet()
        
        let item3 = Item()
        item3.quantidade = 2
        item3.produto = Produto()
        item3.produto?.nome = "Café 3 Corações"
        item3.produto?.preco = 20
        item3.produto?.tipo = "Café"
        item3.produto?.oferta = false
        item3.produto?.precoOferta = 9
        item3.produto?.descricao = "Descrição do Café"
        
        let item4 = Item()
        item4.quantidade = 3
        item4.produto = Produto()
        item4.produto?.nome = "Café Illy"
        item4.produto?.preco = 50
        item4.produto?.tipo = "Café"
        item4.produto?.oferta = false
        item4.produto?.descricao = "Descrição do Café"
        
        ped2.items?.adding(item3)
        ped2.items?.adding(item4)
        
        pedidos.append(ped2)
        
        return pedidos
    }
    
}
