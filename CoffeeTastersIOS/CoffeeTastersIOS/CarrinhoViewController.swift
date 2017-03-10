//
//  CarrinhoViewController.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class CarrinhoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet weak var qtdItensLabel: UILabel!
    @IBOutlet weak var valorTotalLabel: UILabel!
    
    var carrinho: Carrinho?
    
    override func viewDidLoad() {
        carrinho = CarrinhoDao().getCarrinho()
        
        qtdItensLabel.text = "\((carrinho?.items?.count)!)"
        
        var total = 0.0
        for i in (carrinho?.items!.allObjects as! [Item]) {
            total += (i.produto?.preco)! * Double(i.quantidade)
        }
        valorTotalLabel.text = "R$ \(total)"
    }
    
    // Funcionalidades da Tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (carrinho?.items?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itens", for: indexPath) as! CarrinhoCustomViewCellItem
            
            let items = carrinho?.items!.allObjects as! [Item]
            
            let valorDoItem = (items[indexPath.row].produto?.preco)!*Double((items[indexPath.row].quantidade))
            
            cell.nome?.text = items[indexPath.row].produto?.nome
            cell.quantidade?.text = "\(items[indexPath.row].quantidade)"
            cell.valor?.text = "R$ \(valorDoItem)"
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            print("Linha Selecionada:  \(indexPath.row) e section: \(indexPath.section)")
        }
    }

}
