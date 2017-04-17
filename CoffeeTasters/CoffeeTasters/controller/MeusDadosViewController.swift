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

class MeusDadosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var inputAcessoryBar: UIToolbar!
    
    @IBOutlet weak var imagem: RoundImage!
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
        
        tipoCartaoImageView.image = CreditCardUtil().creditCardType(numeroCartaoTextField.text!)
        
        if ( usuario.perfilImg == "FOTO" ) {
            imagem.image = usuario.imagem
        } else {
            if usuario.perfilImg != "" {
                imagem.af_setImage(withURL: URL(string: usuario.perfilImg)!)
            }
        }
        let tapFoto = UITapGestureRecognizer(target: self, action: #selector(selecionaFoto))
        imagem?.addGestureRecognizer(tapFoto)
        imagem.isUserInteractionEnabled = true
        
        let validadeCartaoPickerView = ValidadeCartaoPickerView()
        validadeCartaoPickerView.onDateSelected = { (month: String, year: String) in
            self.validadeCartaoTextField.text = "\(month)/\(year)"
        }
        
        initializeInputAccessoryBar()
        
        validadeCartaoTextField.inputView = validadeCartaoPickerView
        validadeCartaoTextField.inputAccessoryView = inputAcessoryBar
        
    }
    
    @IBAction func escrevendoNumeroCartao(_ sender: UITextField) {
        tipoCartaoImageView.image = CreditCardUtil().creditCardType(sender.text!)
    }

    func selecionaFoto() {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            mostraPickerQuandoTemCamera(pickerController: pickerController){
                self.present(pickerController, animated: true, completion: nil)
            }
        } else {
            pickerController.sourceType = .photoLibrary
            navigationController?.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imagem?.image = image
            usuario.imagem = image
            usuario.perfilImg = "FOTO"
            usuario.save()
        
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func mostraPickerQuandoTemCamera(pickerController: UIImagePickerController, mostrar: @escaping ()->Void) {
        let alerta = UIAlertController(title: "Escolha a origem...", message: "", preferredStyle: .actionSheet)
        
        alerta.addAction(UIAlertAction(title: "Camera", style: .default) { action in
            pickerController.sourceType = .camera
            mostrar()
        })
        
        alerta.addAction(UIAlertAction(title: "Biblioteca", style: .default) { action in
            pickerController.sourceType = .photoLibrary
            mostrar()
        })
        
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { action in
            alerta.dismiss(animated: true, completion: nil)
        })
        
        self.present(alerta, animated: true, completion: nil)
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
            
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "loginScreen")
            
            self.navigationController?.present(view, animated: true, completion: nil)
            
        })
        alerta.addAction(UIAlertAction(title: "Cancelar", style: .cancel) {
            (UIAlertAction) in
            
        })
            
        if let nav = navigationController {
            nav.present(alerta, animated: true, completion: nil)
        }
    }
    
    func initializeInputAccessoryBar() {
        inputAcessoryBar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissSafraPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBar.items = [flexibleSpace, doneButton]
    }
    
    func dismissSafraPicker() {
        validadeCartaoTextField.resignFirstResponder()
    }
    
}
