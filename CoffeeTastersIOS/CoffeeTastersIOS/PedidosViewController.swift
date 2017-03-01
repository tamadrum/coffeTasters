//
//  PedidosViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class PedidosViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView:UITableView?
    
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
                                        busyAlertController.dismiss()
                                    })
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = "linha de texto \(row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell != nil {
            print("Linha Selecionada:  \(indexPath.row)")
        }
    }
    
}
