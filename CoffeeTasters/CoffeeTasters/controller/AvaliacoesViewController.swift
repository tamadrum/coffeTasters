//
//  AvaliacoesViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class AvaliacoesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView?
    var avaliacoes:[Avaliacao] = []
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avaliacoes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! AvaliacaoCustomCell
        
        cell.nav = self.navigationController
        
        cell.imagem = (avaliacoes[indexPath.row].cafe?.imagem as! UIImage)
        cell.comentario.text = avaliacoes[indexPath.row].obs
        cell.flavor.flavorUsuario = avaliacoes[indexPath.row].flavor
        cell.modoPrepado.text = avaliacoes[indexPath.row].metodoPreparo
        cell.nomeCafe.text = avaliacoes[indexPath.row].cafe?.nome
        cell.rating.rating = Float(avaliacoes[indexPath.row].gostou)
        cell.safra.text = avaliacoes[indexPath.row].data
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
}
