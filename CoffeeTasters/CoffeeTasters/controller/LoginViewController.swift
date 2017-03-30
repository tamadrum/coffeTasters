//
//  LoginViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/29/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var logoImageView:UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.logoImageView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2, animations: {
            self.logoImageView.alpha = 1.0
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRegistro" {
            
        }
        if segue.identifier == "segueEsqueciASenha" {
            
        }
        if segue.identifier == "segueEntrar" {
            
        }
    }
}
