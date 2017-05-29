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
//    var nomesCafes:[String] = []
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
//        let daoCafes = Dao<Cafe>()
//        cafes = daoCafes.list()
        let dao = AvaliacaoDao()
        cafes = dao.getListaCafes()
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let viewDetalhes = storyboard.instantiateViewController(withIdentifier: "detalhesCafe") as! DetalhesCafeController
        
        viewDetalhes.cafeAvaliado = cafes[indexPath.row]
        navigationController?.pushViewController(viewDetalhes, animated: true)

    }
    
}
