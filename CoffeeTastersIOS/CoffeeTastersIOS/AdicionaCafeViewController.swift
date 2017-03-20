//
//  AdicionaCafeViewController.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/7/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

class AdicionaCafeViewController: UIViewController, UITextFieldDelegate {
    
    var activeTextField: UITextField!
    var viewWasMoved: Bool = false
    var delegate: AtualizaTabela?
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var origemTextField: UITextField!
    @IBOutlet weak var paisTextField: UITextField!
    @IBOutlet weak var cidadeTextField: UITextField!
    @IBOutlet weak var estadoTextField: UITextField!
    @IBOutlet weak var produtorTextField: UITextField!
    @IBOutlet weak var torradorTextField: UITextField!
    @IBOutlet weak var regiaoTextField: UITextField!
    @IBOutlet weak var tipoTextField: UITextField!
    @IBOutlet weak var safraTextField: UITextField!
    
    override func viewDidLoad() {
        title = "Adicionando Café"
        
        nomeTextField.delegate = self
        origemTextField.delegate = self
        paisTextField.delegate = self
        cidadeTextField.delegate = self
        estadoTextField.delegate = self
        produtorTextField.delegate = self
        torradorTextField.delegate = self
        regiaoTextField.delegate = self
        tipoTextField.delegate = self
        safraTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let salvar = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(salvarCafe))
        navigationItem.rightBarButtonItem = salvar
    }
    
    func salvarCafe () {
        
        let dao = Dao<Cafe>(banco: "CDCafe")
        let cafe:Cafe = dao.new()

        cafe.nome = nomeTextField.text
        cafe.origem = origemTextField.text
        cafe.pais = paisTextField.text
        cafe.cidade = cidadeTextField.text
        cafe.estado = estadoTextField.text
        cafe.produtor = produtorTextField.text
        cafe.torrador = torradorTextField.text
        cafe.regiao = regiaoTextField.text
        cafe.tipo = tipoTextField.text
        //cafe.safra = safraTextField.text
        
        dao.save()
        
        delegate?.atualizaTabela()
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func atualizaTabela(){
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        
        let activeTextFieldRect: CGRect? = activeTextField?.frame
        var activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        activeTextFieldOrigin?.x -= (activeTextFieldRect?.height)!
        
        if (!aRect.contains(activeTextFieldOrigin!) && !self.viewWasMoved) {
            self.viewWasMoved = true
            self.view.frame.origin.y -= keyboardSize!.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if (self.viewWasMoved) {
//            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y = 0 //+= keyboardSize.height
                self.viewWasMoved = false
//            }
        }
    }
    
}
