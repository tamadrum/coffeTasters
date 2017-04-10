//
//  CarrinhoViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class CarrinhoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var valorTotalCarrinhoLabel: UILabel!
    var carrinho: Carrinho?
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        recarrega()
    }
    
    func recarrega () {
        carrinho = CarrinhoDao().getCarrinho()
        let itens = carrinho?.itens!.allObjects as! [Item]
        
        var total = 0.0
        for i in itens {
            total += (i.produto?.preco)! * Double(i.quantidade)
        }
        valorTotalCarrinhoLabel.text = "R$ \(total)"
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (carrinho?.itens?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            var itens = (carrinho?.itens?.allObjects as! [Item])
            carrinho?.removeFromItens(itens[indexPath.row])
            CarrinhoDao().delete(itens[indexPath.row])
            CarrinhoDao().save()
            
            recarrega()
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itens", for: indexPath) as! CarrinhoItemCustomCell
            
            let items = carrinho?.itens!.allObjects as! [Item]
            
            let valorDoItem = (items[indexPath.row].produto?.preco)!*Double((items[indexPath.row].quantidade))
            
            cell.descricaoLabel?.text = items[indexPath.row].produto?.nome
            
            cell.qtdLabel?.text = "\(items[indexPath.row].quantidade)"
            cell.valorUnitarioLabel?.text = "R$ \(valorDoItem)"
            
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
    }
    
    
    
}
