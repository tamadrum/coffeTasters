//
//  BuscaViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

protocol AtualizaTabela{
    func atualizaTabela()
}

class BuscaViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AtualizaTabela {
    
    @IBOutlet var tableView:UITableView?
    @IBOutlet weak var campoBusca: UISearchBar!
    var delegate:AtualizaTabela?
    
    var searchActive : Bool = false
    var data:Array<Cafe> = []
    var filtered:Array<Cafe> = []
    
    override func viewDidLoad() {
        tableView?.delegate = self
        tableView?.dataSource = self
        campoBusca.delegate = self
        
        let maisCafe = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(adicionaCafe))
        navigationItem.rightBarButtonItem = maisCafe
        
        data = Dao<Cafe>(banco: "CDCafe").list()
        tableView?.reloadData()
    }
    
    func atualizaTabela(){
        data = Dao<Cafe>(banco: "CDCafe").list()
        tableView?.reloadData()
    }

    func adicionaCafe () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "telaAdicionaCafe") as! AdicionaCafeViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath)
        
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
        //let cell = tableView.cellForRow(at: indexPath)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detalhesCafe") as! DetalhesViewController
        if(searchActive){
            vc.cafeAvaliado = filtered[indexPath.row]
        } else {
            vc.cafeAvaliado = data[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
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


}
