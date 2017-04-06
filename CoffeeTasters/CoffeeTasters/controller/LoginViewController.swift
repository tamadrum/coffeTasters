//
//  LoginViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/29/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController, LoginButtonDelegate, UIWebViewDelegate {
    
    @IBOutlet var logoImageView:UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var viewLogin: UIView!
    
    var usuario:Usuario = Usuario()
    
    override func viewDidLoad() {
        
        usuario.load()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .userFriends, .email ])
        var position = view.center
        position.y += 200
        loginButton.center = position
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
            print("Vc já estava logado e seu id eh \(accessToken)")
            fetchProfile()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.logoImageView.alpha = 0.0
        
        if !usuario.viuEULA{
            
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
                self.usuario.viuEULA = true
                self.usuario.save()
            })
            alerta.addAction(ok)
            
            self.present(alerta, animated: true, completion: nil)
        } else {
            
        }
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
    
    // MARK: Coisas do facebook
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Saiu do app pelo Facebook")
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        GraphRequest(graphPath: "/me", parameters: parameters).start({(request, result) in
            print(result)
            
            
            
            //            if let email = result["email"] as? String {
            //
            //            }
            
            
        })
    }
    
}
