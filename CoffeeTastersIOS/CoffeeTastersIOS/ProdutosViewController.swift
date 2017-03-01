//
//  ProdutosViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class ProdutosViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView:UITableView?
    
    var data = Array<Produto>()

    override func viewDidLoad() {
        let busyAlertController: BusyAlert = {
            let busyAlert = BusyAlert(title: "Carregando...", message: "\n\nAguarde por favor!", presentingViewController: self)
            return busyAlert
        }()
        
        busyAlertController.display()
        
        SyncUtil().getDadosFrom(url: "http://www.kaleidosblog.com/tutorial/tutorial.json",
            trataJson: { (result: Data) in
                let r = SyncUtil().extract_json(jsonData: result)
                print("got back: \(r)")
                return ""
            },
            finish: { (dados: Any) in
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                    
                    self.data = ProdutoDao().getProdutos(comOferta: false)
                    self.tableView?.reloadData()
                    busyAlertController.dismiss()
                })
            })
    }
    
    // Funcionalidades da Tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].nome
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            print("Linha Selecionada:  \(indexPath.row)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
