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
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! CustomCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itens", for: indexPath) as! CustomCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            data.remove(at: 2)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            print("Linha Selecionada:  \(indexPath.row)")
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            data.remove(at: 2)
            tableView.reloadData()
        }
    }

}
