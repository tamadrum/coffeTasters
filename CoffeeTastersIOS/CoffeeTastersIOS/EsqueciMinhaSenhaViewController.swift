//
//  EsqueciMinhaSenhaViewController.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/24/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import MessageUI

class EsqueciMinhaSenhaViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
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
