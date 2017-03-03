//
//  PedidosViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class PedidosViewController:AcordeaoPedido {
    
    @IBOutlet var tableView:UITableView?
    
    override func viewDidLoad() {
        tableView?.tableFooterView = UIView()
        
        var items = Array<ParentPedido>()
        
        for l in PedidoDao().getListaPedidos() {
            items.append(ParentPedido(state: .collapsed, item: l))
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
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
//        print("Parent: \(parent) isParentCell: \(isParentCell) posicao: \(actualPosition)")
//        
//        return tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath)
//        
        
        if isParentCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! PedidosCustomViewCellHeader
            
            let ped = self.dataSource[parent].item //[indexPath.row - actualPosition - 1]
            
            cell.numero?.text = "\(ped.numero)"
            cell.status?.text = ped.status
            cell.valor?.text = "R$ \(ped.valorTotal)"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! PedidosCustomViewCellDetails

            let item = dataSource[parent].item.items[indexPath.row - actualPosition - 1]
            
            cell.quantidade?.text = "\(item.quantidade)"
            cell.nome?.text = item.produto.nome
            cell.valor?.text = "R$ \(item.produto.preco)"
            
            return cell
        }
    }
    
}
