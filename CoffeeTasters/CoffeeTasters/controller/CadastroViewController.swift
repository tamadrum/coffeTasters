//
//  CadastroViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class CadastroViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var repitaSenhaTextField: UITextField!
    
    var usuario = Usuario()
    
    override func viewDidLoad() {
        usuario.load()
    }
    
    @IBAction func salvarCadastro(_ sender: UIButton) {
        if ( senhaTextField.text == repitaSenhaTextField.text ) {
            usuario.nome = nomeTextField.text!
            usuario.email = emailTextField.text!
            usuario.senha = senhaTextField.text!
            usuario.save()
            
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "inicioTab")
            present(view, animated: false, completion: nil)
            
        } else {
            let alerta = UIAlertController(title: "Senhas incorretas!", message: "O campo senha e o campo repita a senha devem ser iguais!", preferredStyle: .actionSheet)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel) {
                UIAlertAction in
                self.repitaSenhaTextField.text = ""
                self.senhaTextField.text = ""
            })
            present(alerta, animated: true, completion: nil)
        }
        
    }
    
}
