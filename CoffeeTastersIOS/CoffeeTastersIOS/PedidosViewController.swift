//
//  PedidosViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class PedidosViewController:Acordeao {
    
    @IBOutlet var tableView:UITableView?
    
    override func viewDidLoad() {
        tableView?.tableFooterView = UIView()
        
        var items = Array<Parent>()
        
        for l in PedidoDao().getListaPedidos() {
            items.append(Parent(state: .collapsed, item: l))
        }
        
        self.parentCellIdentifier = "header"
        self.childCellIdentifier = "details"
        self.heightParent = 100
        self.heightChild = 44
        self.dataSource = items
        self.numberOfCellsExpanded = .one
        self.total = self.dataSource.count
        
        self.tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (_, isParentCell, _) = self.findParent(indexPath.row)
        
        if isParentCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! PedidosCustomViewCellHeader
            
            let ped = dataSource[indexPath.row].item as! Pedido
            
            cell.numero?.text = "\(ped.numero)"
            cell.status?.text = ped.status
            cell.valor?.text = "R$ \(ped.valorTotal)"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! PedidosCustomViewCellDetails
            
            let ped = dataSource[indexPath.row-1].item as! Pedido
            
            cell.quantidade?.text = "\(ped.items[0].quantidade)"
            cell.nome?.text = ped.items[0].produto.nome
            cell.valor?.text = "R$ \(ped.items[0].produto.preco)"
            
            return cell
        }
    }
    
}
