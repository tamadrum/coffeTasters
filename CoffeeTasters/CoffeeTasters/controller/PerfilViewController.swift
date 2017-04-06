//
//  PerfilViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/30/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class PerfilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imagemUsuario: UIImageView!
    
    
    var searchActive : Bool = false
    var data:[Cafe] = []
    var filtered:[Cafe] = []
    
    let usuario = Usuario()
    
    @IBAction func irParaAvaliacoes(_ sender: UIButton) {
        if tabBarController != nil {
            tabBarController?.selectedIndex = 2;
        }
    }
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        usuario.load()
        print("Perfil : \(usuario.perfilImg)")
        imagemUsuario.af_setImage(withURL: URL(string: usuario.perfilImg)!)
        
        data = CafeDao().listar()
        
        data.sort(by: {(cafe1, cafe2) -> Bool in
            return cafe1.nome!<cafe2.nome!
        })
        //data.append("Adicionar um café...")
        
        tableView?.reloadData()
    }
    
    // MARK: Coisas da busca
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = -300
            searchBar.text = ""
        })
        
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = 108
        })
        
        filtered = data.filter({ (cafe) -> Bool in
            if cafe.nome?.range(of: searchText) != nil {
                return true
            }
            else {
                return false
            }
        })
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        self.tableView?.reloadData()
    }
    
    // MARK: Coisas da tabela
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! BuscaResultCustomCell
        
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row].nome
            cell.detailTextLabel?.text = filtered[indexPath.row].descricao
            //            cell.imageView?.image = UIImage(named: filtered[indexPath.row].descricao)
        } else {
            cell.textLabel?.text = data[indexPath.row].nome
            cell.detailTextLabel?.text = data[indexPath.row].descricao
            //            cell.imageView?.image = UIImage(named: data[indexPath.row].imagem)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "detalhesCafe") as! DetalhesCafeController
        
        if(searchActive){
            view.cafeAvaliado = filtered[indexPath.row]
        } else {
            view.cafeAvaliado = data[indexPath.row]
        }
        
//        if ( indexPath.row == data.count-1 ) {
//            view = storyboard.instantiateViewController(withIdentifier: "avaliacao")
//        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = -300
        })
        
        navigationController?.pushViewController(view, animated: true)
    }
}
