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
    var searchActive : Bool = false
    var data:[Cafe] = []
    var filtered:[Cafe] = []
    
    let usuario = Usuario()
    
    @IBOutlet weak var qtdAvaliacoes: UILabel!
    @IBOutlet weak var qtdCafes: UILabel!
    @IBOutlet weak var qtdCafeterias: UILabel!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var sobrenomeUsuario: UILabel!
    @IBOutlet weak var emailUsuario: UILabel!
    @IBOutlet weak var imagemUsuario: UIImageView!
    
    @IBAction func irParaAvaliacoes(_ sender: UIButton) {
        if tabBarController != nil {
            tabBarController?.selectedIndex = 2;
        }
    }
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        usuario.load()
        
        imagemUsuario.af_setImage(withURL: URL(string: usuario.perfilImg)!)
        nomeUsuario.text = usuario.nome
        sobrenomeUsuario.text = usuario.sobrenome
        emailUsuario.text = usuario.email
        
        qtdCafeterias.text = "\(AvaliacaoDao().getListaCafeterias().count)"
        qtdAvaliacoes.text = "\(AvaliacaoDao().count())"
        
        data = Dao<Cafe>().list()
        qtdCafes.text = "\(data.count)"
        
        data.sort(by: {(cafe1, cafe2) -> Bool in
            return cafe1.nome!<cafe2.nome!
        })
        
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
            return filtered.count+1
        }
        return data.count+1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! BuscaResultCustomCell
        
        if(searchActive){
            if ( indexPath.row == filtered.count ) {
                cell.textLabel?.text = "Adicionar um Café"
                cell.imagemLogo?.image = nil
            } else {
                cell.nome?.text = filtered[indexPath.row].nome
                cell.imagemLogo?.image = filtered[indexPath.row].imagem as? UIImage
            }
        } else {
            if ( indexPath.row == data.count ) {
                cell.textLabel?.text = "Adicionar um Café"
                cell.imagemLogo?.image = nil
            } else {
                cell.nome?.text = data[indexPath.row].nome
                cell.imagemLogo?.image = data[indexPath.row].imagem as? UIImage
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame.origin.y = -300
        })
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let viewDetalhes = storyboard.instantiateViewController(withIdentifier: "detalhesCafe") as! DetalhesCafeController
        let viewAvaliacao = storyboard.instantiateViewController(withIdentifier: "avaliacao") as! AvaliacaoViewController
        
        if(searchActive){
            if ( indexPath.row == filtered.count ) {
                navigationController?.pushViewController(viewAvaliacao, animated: true)
            } else {
                viewDetalhes.cafeAvaliado = filtered[indexPath.row]
                navigationController?.pushViewController(viewDetalhes, animated: true)
            }
        } else {
            if ( indexPath.row == data.count ) {
                navigationController?.pushViewController(viewAvaliacao, animated: true)
            } else {
                viewDetalhes.cafeAvaliado = data[indexPath.row]
                navigationController?.pushViewController(viewDetalhes, animated: true)
            }
        }
    }
}
