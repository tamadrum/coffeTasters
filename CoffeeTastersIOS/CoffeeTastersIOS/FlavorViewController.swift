//
//  FlavorViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class FlavorViewController:UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var labels = ["Doce", "Azedo", "Floral", "Especiarias", "Salgado", "Frutas Vermelhas", "Frutas Cítricas", "Frutas Caroço", "Chocolate", "Caramelo", "Defumado", "Amargo", "Herbal", "Encorpado", "Cereais", "Nozes"]
    
    var valores = [1, 3, 9, 1, 5, 4, 3, 5, 6, 7, 6, 1, 9, 8, 9, 3]
    
    @IBAction func salvar(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! FlavorCustomViewCell
        
        cell.flavor?.text = labels[indexPath.row]
        
        cell.valor?.value = Float(valores[indexPath.row])
        
        cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        
        return cell
    }
    
}
