//
//  ComprarAlertViewController.swift
//  MapaExemplo
//
//  Created by Ettore Luglio on 3/2/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

/// Alerta para mandar comprar o produto
class ComprarAlertViewController {
    
    let controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    
    /**
     Acha o item no delegate
     
     - Parameter titulo: Titulo da mensagem
     - Parameter message: Mensagem que será exibida
     
     */
    func show(_ title:String = "Titulo", message:String = "Mensagem", produto: Produto) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Adicionar", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            let qtd = Int(firstTextField.text!)!
            
            let item = ItemDao().newItem()
            item.quantidade = Int32(qtd)
            item.produto = produto
            
            let carrinho = CarrinhoDao().getCarrinho()
            carrinho.addToItems(item)
            carrinho.valorTotal += produto.preco * Double(qtd)
            
            CarrinhoDao().save()
        
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
