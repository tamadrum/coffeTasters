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
    @IBOutlet weak var tipoCartaoImagem: UIImageView!
    
    var usuario = Usuario()
    
    func carregaUsuario(_ usuario: Usuario) {
        self.usuario = usuario
    }
    
    override func viewDidLoad() {
        self.nomeTextField?.text = usuario.nome
        self.emailTextField?.text = usuario.email
        self.cpfTextField?.text = usuario.cpf
        self.nomeCartaoTextField?.text = usuario.nomeCartao
        self.numeroCartaoTextField?.text = mostraAsteriscos(usuario.numeroCartao)
        self.validadeCartaoTextField?.text = usuario.validadeCartao
        
        tipoCartaoImagem.image = CreditCardUtil().creditCardType(usuario.numeroCartao)
    }
    
    @IBAction func salvar(_ sender: Any) {
            if let nome = nomeTextField.text { usuario.nome = nome }
            if let email = emailTextField.text { usuario.email = email }
            if let cpf = cpfTextField.text {
                if cpf.isCPF() {
                    usuario.cpf = cpf
                }
            }
            if let senha = senhaTextField.text { usuario.senha = senha }
            if let nomeCartao = nomeCartaoTextField.text { usuario.nomeCartao = nomeCartao }
            if let numeroCartao = numeroCartaoTextField.text { usuario.numeroCartao = numeroCartao }
            if let validadeCartaoTextField = validadeCartaoTextField.text { usuario.validadeCartao = validadeCartaoTextField }
            
            usuario.save()
    
        if let navigator = navigationController {
            navigator.popViewController(animated: true)
        }
    }
    
    func mostraAsteriscos(_ texto: String) -> String {
        if ( texto.characters.count > 14 ) {
            let start1 = texto.index(texto.startIndex, offsetBy: 0)
            let end1 = texto.index(texto.startIndex, offsetBy: 4)
            let range1 = start1..<end1
            
            let start2 = texto.index(texto.endIndex, offsetBy: -8)
            let end2 = texto.index(texto.endIndex, offsetBy: -4)
            let range2 = start2..<end2
            
            return "\(texto.substring(with: range1))********\(texto.substring(with: range2))"
        }
        return ""
    }
    
    @IBAction func escreveuNumero(_ sender: UITextField) {
        tipoCartaoImagem.image = CreditCardUtil().creditCardType(sender.text!)
    }
}
