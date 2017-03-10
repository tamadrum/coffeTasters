//
//  LoginController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import Foundation
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class LoginViewController:UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var senhaTextField: UITextField!
    
    @IBOutlet var esqueciMinhaSenha: UIButton!
    @IBOutlet var registrar: UIButton!
    @IBOutlet var entrar: UIButton!
    
    var usuario:Usuario = Usuario()
    
    override func viewDidLoad() {
        usuario.load()
        
        let loginButton : FBSDKLoginButton = FBSDKLoginButton()
        var posicao:CGPoint = view.center
        posicao.y += 200
        loginButton.center = posicao
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !usuario.viuOEULA {
            
            let alerta = UIAlertController(title: "EULA", message: "LEIA", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                self.usuario.viuOEULA = true
                self.usuario.save()
            })
            alerta.addAction(ok)
            
            self.present(alerta, animated: true, completion: nil)
        } else {
            if (FBSDKAccessToken.current() != nil) {
                print("Facebook O token nao estava vazio!!! \(FBSDKAccessToken.current())")
                returnUserData()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let perfil = storyboard.instantiateViewController(withIdentifier: "PerfilController") as! PerfilViewController
                self.present(perfil, animated: true, completion: nil)
                
            }
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let userToken = result.token {
            let token:FBSDKAccessToken = userToken
            print(token)
            //print token id and user id
            print("Facebook TOKEN IS \(FBSDKAccessToken.current().tokenString)")
            print("Facebook USER ID IS \(FBSDKAccessToken.current().userID)")
            
        }
        
        if ((error) != nil) {
            
        } else if result.isCancelled {
            
        } else {
            if result.grantedPermissions.contains("email") {
                print("Facebook email autorizado")
            }
            
            returnUserData()
            print("Facebook autenticou pelo botao")
            
            self.performSegue(withIdentifier: "telaPerfil", sender: self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Facebook User Logged Out")
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                print("Facebook Error: \(error)")
            } else {
                if let user = result as? [String:Any] {
                    print("Facebook fetched user: \(user)")
                    if let id = user["id"] {
                        self.usuario.perfilPic = "http://graph.facebook.com/\(id)/picture?type=large"
                        print("Facebook guardei id: \(id)")
                    }
                    if let nome = user["name"] {
                        self.usuario.nome = nome as! String
                        print("Facebook guardei nome: \(nome)")
                    }
                    if let email = user["email"] {
                        self.usuario.email = email as! String
                        print("Facebook guardei email: \(email)")
                    }
                    
                    self.usuario.save()
                }
            }
        })
    }
    
        
}
