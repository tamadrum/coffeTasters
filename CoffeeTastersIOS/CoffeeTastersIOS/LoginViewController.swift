//
//  LoginController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController:UIViewController{
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var senhaTextField: UITextField!
    
    @IBOutlet var esqueciMinhaSenha: UIButton!
    @IBOutlet var registrar: UIButton!
    @IBOutlet var entrar: UIButton!
    
    override func viewDidLoad() {
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email"]
        var posicao:CGPoint = view.center
        posicao.y += 200
        loginButton.center = posicao
        view.addSubview(loginButton)
    }
    
}
