//
//  MeusDadosViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/29/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin

class MeusDadosViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var repitaTextField: UITextField!
    @IBOutlet weak var nomeCartaoTextField: UITextField!
    @IBOutlet weak var numeroCartaoTextField: UITextField!
    @IBOutlet weak var validadeCartaoTextField: UITextField!
    @IBOutlet weak var tipoCartaoImageView: UIImageView!
    @IBOutlet weak var receberNotificacaoSegmentControl: UISegmentedControl!
    
    var usuario = Usuario()
    
    override func viewDidLoad() {
        usuario.load()
        
        nomeTextField.text = usuario.nome
        emailTextField.text = usuario.email
        cpfTextField.text = usuario.cpf
        senhaTextField.text = usuario.senha
        nomeCartaoTextField.text = usuario.nomeCartao
        numeroCartaoTextField.text = usuario.numeroCartao
        validadeCartaoTextField.text = usuario.validadeCartao
        receberNotificacaoSegmentControl.selectedSegmentIndex = usuario.querNotificacao ? 0 : 1
        
    }
    
    @IBAction func salvar(_ sender: UIBarButtonItem) {
        usuario.nome = nomeTextField.text!
        usuario.email = emailTextField.text!
        usuario.cpf = cpfTextField.text!
        usuario.senha = senhaTextField.text!
        usuario.nomeCartao = nomeCartaoTextField.text!
        usuario.numeroCartao = numeroCartaoTextField.text!
        usuario.validadeCartao = validadeCartaoTextField.text!
        usuario.querNotificacao = receberNotificacaoSegmentControl.selectedSegmentIndex == 0 ? true : false
        
        usuario.save()
        
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    @IBAction func sairConta(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Logout...", message: "Deseja efetuar o logout?", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Sair", style: .default) {
            (UIAlertAction) in
        
            LoginManager().logOut()
            
            exit(0)
            
        })
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel) {
            (UIAlertAction) in
            
        })
            
        if let nav = navigationController {
            nav.present(alerta, animated: true, completion: nil)
        }
    }
    
}
