//
//  CoffeeTasters.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class CafeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cafes:[Cafe] = []
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        let dao = Dao<Cafe>()
        cafes = dao.list()
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! CafeCustomCell
        
        cell.imagemLogo.image = #imageLiteral(resourceName: "cafe")
        cell.nome.text = cafes[indexPath.row].nome
        
        return cell
    }
    
}
