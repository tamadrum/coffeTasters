//
//  PedidoDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class PedidoDao {
    
    func getListaPedidos () -> Array<Pedido> {
        var pedidos = Array<Pedido>()
        
        let ped1 = Pedido()
        ped1.numero = 102138371
        ped1.status = "Em processamento..."
        ped1.valorTotal = 100
        ped1.items = Array<Item>()
        
        let item1 = Item()
        item1.quantidade = 2
        item1.produto = Produto()
        item1.produto.nome = "Café Pelé"
        item1.produto.preco = 10
        item1.produto.tipo = "Café"
        item1.produto.oferta = true
        item1.produto.precoOferta = 9
        item1.produto.descricao = "Descrição do Café"
        
        let item2 = Item()
        item2.quantidade = 3
        item2.produto = Produto()
        item2.produto.nome = "Café Pilão"
        item2.produto.preco = 20
        item2.produto.tipo = "Café"
        item2.produto.oferta = false
        item2.produto.descricao = "Descrição do Café"
        
        ped1.items.append(item1)
        ped1.items.append(item2)
        
        pedidos.append(ped1)
        
        return pedidos
    }
    
}
