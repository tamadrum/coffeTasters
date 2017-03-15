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
import WebKit

class LoginViewController:UIViewController, FBSDKLoginButtonDelegate, UIWebViewDelegate {
    
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
        
        if (FBSDKAccessToken.current() != nil) {
            print("Facebook O token nao estava vazio!!! \(FBSDKAccessToken.current())")
            returnUserData()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let perfil = storyboard.instantiateViewController(withIdentifier: "PerfilController") as! PerfilViewController
            self.present(perfil, animated: true, completion: nil)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !usuario.viuOEULA {
            
            let alerta = UIAlertController(title: "EULA", message: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            
            let web = UIWebView(frame: CGRect(x:12.0, y:45.0, width:240.0, height:300.0))
            web.delegate = self
            
            var text = ""
            if let path = Bundle.main.path(forResource: "EULA", ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    let myStrings = data.components(separatedBy: .newlines)
                    text = myStrings.joined(separator: ", ")
                } catch {
                    print(error)
                }
            }
            
            web.loadHTMLString(text, baseURL: nil)
            
            alerta.view.addSubview(web)

            let ok = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                self.usuario.viuOEULA = true
                self.usuario.save()
            })
            alerta.addAction(ok)
            
            self.present(alerta, animated: true, completion: nil)
        } else {
            
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
