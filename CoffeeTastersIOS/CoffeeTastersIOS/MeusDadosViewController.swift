//
//  MeusDadosViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class MeusDadosViewController:UIViewController{
    @IBOutlet var nomeTextField:UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var cpfTextField: UITextField!
    @IBOutlet var senhaTextField: UITextField!
    @IBOutlet var repitaTextField: UITextField!
    @IBOutlet var nomeCartaoTextField: UITextField!
    @IBOutlet var numeroCartaoTextField: UITextField!
    @IBOutlet var validadeCartaoTextField: UITextField!
    @IBOutlet var tipoCartaoTextField: UITextField!
    
    var usuario = Usuario()
    
    func carregaUsuario(_ usuario: Usuario) {
        self.usuario = usuario
    }
    
    override func viewDidLoad() {
        self.nomeTextField?.text = usuario.nome
        self.emailTextField?.text = usuario.email
        self.cpfTextField?.text = usuario.cpf
        self.nomeCartaoTextField?.text = usuario.nomeCartao
        self.numeroCartaoTextField?.text = usuario.numeroCartao
        self.validadeCartaoTextField?.text = usuario.validadeCartao
        self.tipoCartaoTextField?.text = usuario.tipoCartao
    }
    
    @IBAction func salvar(_ sender: Any) {
            if let nome = nomeTextField.text { usuario.nome = nome }
            if let email = emailTextField.text { usuario.email = email }
            if let cpf = cpfTextField.text { usuario.cpf = cpf }
            if let senha = senhaTextField.text { usuario.senha = senha }
            if let nomeCartao = nomeCartaoTextField.text { usuario.nomeCartao = nomeCartao }
            if let numeroCartao = numeroCartaoTextField.text { usuario.numeroCartao = numeroCartao }
            if let validadeCartaoTextField = validadeCartaoTextField.text { usuario.validadeCartao = validadeCartaoTextField }
            if let tipoCartao = tipoCartaoTextField.text { usuario.tipoCartao = tipoCartao }
            
            Dao().save(usuario)
    
        if let navigator = navigationController {
            navigator.popViewController(animated: true)
        }
    }

}
