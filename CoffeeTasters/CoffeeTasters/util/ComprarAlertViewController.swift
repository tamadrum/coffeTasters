//
//  ComprarAlertViewController.swift
//  MapaExemplo
//
//  Created by Ettore Luglio on 3/2/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit
import CoreData


/// Alerta para mandar comprar o produto
class ComprarAlertViewController {
    
    let controller:UIViewController
    
    init(_ controller:UIViewController){
        self.controller = controller
    }
    
    /**
     Motra amensagem e adiciona no carrinho de compras com a quantidade
     
     - Parameter titulo: Titulo da mensagem
     - Parameter message: Mensagem que será exibida
     - Parameter produto: O produto que o cliente deseja comprar
     
     */
    func show(_ title:String = "Titulo", message:String = "Mensagem", produto: Produto) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Adicionar", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            let qtd = Int32(firstTextField.text!)!
            
            print("Contexto do produto: \(produto.managedObjectContext!)")
            
            let itemDao = Dao<Item>()
            itemDao.reset()
            let item = itemDao.new()
            item.quantidade = qtd
            item.produto = produto
            itemDao.save()
            print("Consegui salvar o item")
            
            let carrinhoDao = CarrinhoDao()
            let carrinho = carrinhoDao.getCarrinho()
            carrinho.addToItens(item)
            carrinho.valorTotal += produto.preco * Double(qtd)
            carrinhoDao.save()
        
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Digite a quantidade..."
            textField.text = "1"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
}
