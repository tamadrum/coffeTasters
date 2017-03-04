//
//  Pedidos.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/23/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class Item {
    var produto: Produto = Produto()
    var quantidade: Int = 0
}

class Pedido {
    var data: Date = Date()
    var numero: Int = 0
    var items:Array<Item> = []
    var status: String = ""
    var valorTotal: Double = 0.0
}
