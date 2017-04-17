//
//  CarrinhoViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class CarrinhoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var valorTotalCarrinhoLabel: UILabel!
    var carrinho: Carrinho!
    
    var valorTotal: Double!
    
    // MARK: Ciclo de vida
    
    override func viewWillAppear(_ animated: Bool) {
        recarrega()
    }
    
    func recarrega () {
        carrinho = CarrinhoDao().getCarrinho()
        let itens = carrinho.itens!.allObjects as! [Item]
        
        var total = 0.0
        for i in itens {
            total += (i.produto?.preco)! * Double(i.quantidade)
        }
        valorTotal = total
        valorTotalCarrinhoLabel.text = Formatadores().formatCurrency(value: total)
        
        tableView.reloadData()
    }
    
    // MARK: 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "telaFinalizar" {
            let tela = segue.destination as! FinalizarCompraViewController
            tela.valorTotal = valorTotal
        }
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (carrinho?.itens?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            var itens = (carrinho?.itens?.allObjects as! [Item])
            
            carrinho?.removeFromItens(itens[indexPath.row])
            CarrinhoDao().getCarrinho().removeFromItens(itens[indexPath.row])
            Dao<Item>().delete(itens[indexPath.row])
            CarrinhoDao().save()
            
            recarrega()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itens", for: indexPath) as! CarrinhoItemCustomCell
            
        let items = carrinho?.itens!.allObjects as! [Item]
            
        let valorDoItem = (items[indexPath.row].produto?.preco)!*Double((items[indexPath.row].quantidade))
            
        cell.descricaoLabel?.text = items[indexPath.row].produto?.nome
            
        cell.qtdLabel?.text = "\(items[indexPath.row].quantidade)"
        cell.valorUnitarioLabel?.text = Formatadores().formatCurrency(value: valorDoItem)
            
        return cell
    }
    
}
