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
    
    var carrinho: Carrinho?
    var items: [Item]? = nil
    
    override func viewDidLoad() {
        carrinho = CarrinhoDao().getCarrinho()
        items = carrinho?.items?.allObjects as? [Item]
    }
    
    // Funcionalidades da Tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : items!.count
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
            
            cell.nome?.text = items?[0].produto?.nome
            cell.quantidade?.text = "\(items?[0].quantidade)"
            cell.valor?.text = "R$ "
            
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
