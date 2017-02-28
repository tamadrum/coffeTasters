//
//  AvaliacoesViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class AvaliacoesViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = "Adicione um café \(row)"
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(mostraDetalhes))
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    func mostraDetalhes(recognizer:UILongPressGestureRecognizer){
        if ( recognizer.state == UIGestureRecognizerState.began) {
            let cell = recognizer.view as! UITableViewCell
            if let indexPath = tableView?.indexPath(for: cell){
                let row = indexPath.row
                print("Linha selecionada \(row)")
                
                show(row, handler: { action in
                    self.tableView?.reloadData()
                })
            }
            
        }
    }
    
    func show(_ indice: Int, handler: @escaping (UIAlertAction) -> Void) {
        let details = UIAlertController(title: "Um Alerta", message: "Detalhes", preferredStyle: UIAlertControllerStyle.alert)
        
        let remove = UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: handler)
        details.addAction(remove)
        
        let acao = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        details.addAction(acao)
        
        self.navigationController?.present(details, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
