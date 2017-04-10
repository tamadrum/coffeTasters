//
//  CafeteriaListViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class CafeteriaListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cafeterias:[String] = []
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        let dao = AvaliacaoDao()
        cafeterias = dao.getListaCafeterias()
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeterias.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! CafeteriaCustomCell
        
        cell.imagemLogo.image = #imageLiteral(resourceName: "cafe")
        cell.nome.text = cafeterias[indexPath.row]
        
        return cell
    }
    
    
    
}
