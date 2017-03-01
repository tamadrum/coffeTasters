//
//  Pedidos.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/23/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class Pedido {
    var numero: Int = 0
    var usuario: Usuario = Usuario()
    var items:Array<Item> = []
    var status: String = ""
    var valorTotal: Double = 0.0
}
