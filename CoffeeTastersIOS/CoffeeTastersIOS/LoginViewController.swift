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

class LoginViewController:UIViewController, FBSDKLoginButtonDelegate{
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var senhaTextField: UITextField!
    
    @IBOutlet var esqueciMinhaSenha: UIButton!
    @IBOutlet var registrar: UIButton!
    @IBOutlet var entrar: UIButton!
    
    var usuario:Usuario = Dao().load()
    
    override func viewDidLoad() {
        var posicao:CGPoint = view.center
        
        posicao.y += 200
        
        if (FBSDKAccessToken.current() != nil) {
            returnUserData()
            if let navigation = navigationController {
                navigation.pushViewController(PerfilViewController(), animated: true)
            }
        } else {}
            let loginButton : FBSDKLoginButton = FBSDKLoginButton()
            
            loginButton.center = posicao
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.delegate = self
            
            self.view.addSubview(loginButton)
        //}
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        
        if ((error) != nil) {
            
        } else if result.isCancelled {
            
        } else {
            if result.grantedPermissions.contains("email") {
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil) {
                print("Error: \(error)")
            } else {
                if let user = result as? [String:Any] {
                    print("fetched user: \(user)")
                    if let id = user["id"] { self.usuario.perfilPic = "http://graph.facebook.com/\(id)/picture?type=large" }
                    if let nome = user["name"] { self.usuario.nome = nome as! String }
                    if let email = user["email"] { self.usuario.email = email as! String }
                    Dao().save(self.usuario)
                }
            }
        })
    }
    
}
