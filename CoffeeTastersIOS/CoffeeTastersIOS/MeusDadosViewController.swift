//
//  MeusDadosViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class MeusDadosViewController:UIViewController{
    @IBOutlet var nomeTextField:UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var cpfTextField: UITextField!
    @IBOutlet var senhaTextField: UITextField!
    @IBOutlet var repitaTextField: UITextField!
    @IBOutlet var nomeCartaoTextField: UITextField!
    @IBOutlet var numeroCartaoTextField: UITextField!
    @IBOutlet var validadeCartaoTextField: UITextField!
    @IBOutlet var tipoCartaoTextField: UITextField!
    
    var usuario = Dao().load()
    
    convenience init() {
        self.init()
//        nomeTextField.text = usuario.nome
//        emailTextField.text = usuario.email
        
    }
    
    @IBAction func salvar(_ sender: Any) {
//        Dao().save(usuario)
    }

}
