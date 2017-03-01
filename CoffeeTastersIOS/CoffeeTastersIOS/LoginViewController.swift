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
import MessageUI

class LoginViewController:UIViewController, FBSDKLoginButtonDelegate,MFMailComposeViewControllerDelegate {
    
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
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["contato@coffeetasters.com.br"])
        mailComposerVC.setSubject("Esqueci minha senha...")
        mailComposerVC.setMessageBody("E agora?", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let erroEmail = UIAlertController(title: "Impossível mandar email", message: "Você não tem um gerenciador de email configurado!", preferredStyle: UIAlertControllerStyle.alert)
        
        let acao = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        erroEmail.addAction(acao)
        
        self.present(erroEmail, animated: true, completion: nil)
        
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}
