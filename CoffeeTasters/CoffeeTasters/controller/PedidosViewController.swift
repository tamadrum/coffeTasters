//
//  PedidosViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class PedidosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pedidos:[Pedido] = []
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        pedidos = Dao<Pedido>().list();
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! PedidoCustomCell
        
        cell.numeroPedido.text = "\(pedidos[indexPath.row].numero)"
        cell.dataPedido.text = pedidos[indexPath.row].data
        if ( pedidos[indexPath.row].status == "" ) {
            cell.imagemStatusPedido.image = #imageLiteral(resourceName: "status-pedidos")
        } else {
            cell.imagemStatusPedido.image = #imageLiteral(resourceName: "status-pedidos")
        }
        cell.totalPedido.text = "R$ \(pedidos[indexPath.row].valorTotal)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}
