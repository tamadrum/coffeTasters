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
    
    var data:[String] = ["la", "lala", "lalala"]
    
    // Funcionalidades da Tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itens", for: indexPath)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            print("Linha Selecionada:  \(indexPath.row)")
        }
    }

}
