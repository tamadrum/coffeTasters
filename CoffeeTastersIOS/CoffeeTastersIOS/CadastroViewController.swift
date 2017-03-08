//
//  CadastroViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import Foundation

class CadastroViewController:UIViewController{
 
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var senhaTextField: UITextField?
    @IBOutlet weak var repeteSenhaTextField: UITextField?
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        if ( senhaTextField?.text == "" || repeteSenhaTextField?.text == "" || nomeTextField?.text == "" || emailTextField?.text == "") {
            let alertController = UIAlertController(title: "Erro!", message: "Nunhum dos campos podem ser vazios...", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                
            })
            
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            if  senhaTextField?.text != repeteSenhaTextField?.text {
                let alertController = UIAlertController(title: "Erro!", message: "A senha e a repeticão devem ser iguais...", preferredStyle: .alert)
            
                let saveAction = UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                
                })

                alertController.addAction(saveAction)
            
                self.present(alertController, animated: true, completion: nil)
            } else {
                let usuario = Usuario()
            
                usuario.nome = (nomeTextField?.text)!
                usuario.email = (emailTextField?.text)!
                usuario.senha = (senhaTextField?.text)!
            
                usuario.save()
            
                self.performSegue(withIdentifier: "telaPerfilPosRegistro", sender: self)
            }
        }
    }
}
