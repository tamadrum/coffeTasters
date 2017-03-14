//
//  OfertasViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class OfertasViewController:Acordeao {
    
    @IBOutlet var tableView:UITableView?
    var prod: Produto?
    
    override func viewDidLoad() {
        tableView?.tableFooterView = UIView()
        
        var items = Array<Parent>()
        
        for l in ProdutoDao().getProdutos(comOferta: true) {
            items.append(Parent(state: .collapsed, item: l))
        }
        
        self.parentCellIdentifier = "header"
        self.childCellIdentifier = "details"
        self.heightParent = 130
        self.heightChild = 130
        self.dataSource = items
        self.numberOfCellsExpanded = .one
        self.total = self.dataSource.count
        
        self.tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (parent, isParentCell, _) = self.findParent(indexPath.row)
        
        if isParentCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! OfertasCustomViewCellHeader
            
            prod = dataSource[parent].item as? Produto
            
            cell.nome?.text = prod?.nome
            cell.tipo?.text = prod?.tipo
            cell.valor?.text = "R$ \((prod?.preco)!)"
            cell.valorOferta?.text = "R$ \((prod?.precoOferta)!)"
            cell.imagem?.image = #imageLiteral(resourceName: "cafe.jpg")
            
            cell.btnComprar.addTarget(self, action: #selector(comprar), for: .touchUpInside)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! OfertasCustomViewCellDetails
            
            let prod = dataSource[parent].item as? Produto
            
            cell.descricao?.text = prod?.descricao
            
            return cell
        }
    }
    
    func comprar() {
        ComprarAlertViewController(controller: self).show("Comprar", message: "Selecione a quantidade que deseja colocar no carrinho...", produto: prod!)
    }
    
}
