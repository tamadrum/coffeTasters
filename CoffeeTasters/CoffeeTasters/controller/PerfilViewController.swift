//
//  PerfilViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/30/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class PerfilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var itens = ["Café Pelé"]
    
    @IBAction func irParaAvaliacoes(_ sender: UIButton) {
        if tabBarController != nil {
            tabBarController?.selectedIndex = 2;
        }
    }
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        itens.sort()
        itens.append("Adicionar um café...")
    }
    
    // MARK: Coisas da busca
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = 108
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = -300
            searchBar.text = ""
        })
    }
    
    // MARK: Coisas da tabela
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! BuscaResultCustomCell
        cell.nome.text = itens[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        var view = storyboard.instantiateViewController(withIdentifier: "detalhesCafe")
        
        if ( indexPath.row == itens.count-1 ) {
            view = storyboard.instantiateViewController(withIdentifier: "avaliacao")
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
}
