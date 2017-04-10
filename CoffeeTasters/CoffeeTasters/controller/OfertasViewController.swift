//
//  OfertasViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class OfertasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var produtos:[Produto] = []
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        produtos = Dao<Produto>().list()
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! OfertaCustomCell
        
        cell.imagemLogoCafe.image = #imageLiteral(resourceName: "cafe")
        cell.nomeProdutoLabel.text = produtos[indexPath.row].nome
        cell.pequenaDescricaoLabel.text = produtos[indexPath.row].descricao
        cell.rating.rating = 4
        cell.valorCheio.text = "R$ \(produtos[indexPath.row].preco)"
        cell.valorDesconto.text = "R$ \(produtos[indexPath.row].precoOferta)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
