////
//  AvaliacoesViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class AvaliacoesViewController: Acordeao, UpdateAvaliacoesProtocol {

    @IBOutlet var tableView:UITableView?

    override func viewDidLoad() {
        tableView?.tableFooterView = UIView()
        
        var items = Array<Parent>()
        
        for l in Dao<Avaliacao>().list() {
            items.append(Parent(state: .collapsed, item: l))
        }
        
        self.parentCellIdentifier = "header"
        self.childCellIdentifier = "details"
        self.heightParent = 180
        self.heightChild = 300
        self.dataSource = items
        self.numberOfCellsExpanded = .one
        self.total = self.dataSource.count
        
        self.tableView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addAvaliacao") {
            let view = segue.destination as! AvaliacaoViewController
            view.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (parent, isParentCell, actualPosition) = self.findParent(indexPath.row)
        
        let avaliacao = self.dataSource[parent].item as! Avaliacao
        
        if isParentCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: parentCellIdentifier , for: indexPath) as! AvaliacaoCustomCell
            
            cell.selectionStyle = .none
            
            cell.nav = self.navigationController
            cell.vc = self
            
            cell.comentario.text = avaliacao.obs
            cell.modoPrepado.text = avaliacao.metodoPreparo
            cell.nomeCafe.text = avaliacao.cafe?.nome
            cell.rating.rating = Float(avaliacao.gostou)
            cell.safra.text = avaliacao.data
            cell.flavor = avaliacao.flavor
                    
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: childCellIdentifier, for: indexPath) as! AvaliacaoDetailsCell
            
            cell.flavor.flavorUsuario = avaliacao.flavor
            cell.flavor.setNeedsDisplay()
            return cell
        }
    }
    
    func atualizarListaProtocol() {
        var items = Array<Parent>()
        
        for l in Dao<Avaliacao>().list() {
            items.append(Parent(state: .collapsed, item: l))
        }
        
        self.parentCellIdentifier = "header"
        self.childCellIdentifier = "details"
        self.heightParent = 180
        self.heightChild = 300
        self.dataSource = items
        self.numberOfCellsExpanded = .one
        self.total = self.dataSource.count
        
        self.tableView?.reloadData()
    }
    
//    var avaliacoes:[Avaliacao] = []
//    
//    // MARK: Ciclo de vida
//    
//    override func viewWillAppear(_ animated: Bool) {
//        avaliacoes = Dao<Avaliacao>().list()
//        tableView?.reloadData()
//    }
//    
//    // MARK: Coisas de tabela
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return avaliacoes.count
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! AvaliacaoCustomCell
//        
//        cell.selectionStyle = .none
//        
//        cell.nav = self.navigationController
//        
//        cell.comentario.text = avaliacoes[indexPath.row].obs
//        cell.flavor.flavorUsuario = avaliacoes[indexPath.row].flavor
//        cell.modoPrepado.text = avaliacoes[indexPath.row].metodoPreparo
//        cell.nomeCafe.text = avaliacoes[indexPath.row].cafe?.nome
//        cell.rating.rating = Float(avaliacoes[indexPath.row].gostou)
//        cell.safra.text = avaliacoes[indexPath.row].data
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 470 or 300
//    }
    
}
