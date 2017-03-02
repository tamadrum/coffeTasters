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
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! PedidosCustomViewCellDetails
            return cell
        }
    }
    
}
