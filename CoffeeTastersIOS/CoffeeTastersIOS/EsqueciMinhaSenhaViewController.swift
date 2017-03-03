//
//  EsqueciMinhaSenhaViewController.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/24/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import MessageUI

class EsqueciMinhaSenhaViewController: UIViewController {
    
    @IBOutlet weak var emailCadastrado: UITextField!
    
    @IBAction func enviarEmail(_ sender: Any) {
        // Mandar a informacao para o servidor devolver o email de recovery da senha
        
        let alerta = UIAlertController(title: "Recuperando a senha..", message: "Em  breve você receberá um email para refazer a sua senha!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            self.performSegue(withIdentifier: "telaLogin", sender: self)
        })
        alerta.addAction(ok)
        
        self.present(alerta, animated: true, completion: nil)
        
        
    }
    
}
