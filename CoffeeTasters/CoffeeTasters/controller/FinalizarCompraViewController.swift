//
//  FinalizarCompraViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class FinalizarCompraViewController: UIViewController {
    
    var inputAcessoryBar: UIToolbar!
    
    var usuario = Usuario()
    var valorTotal: Double!
    
    @IBOutlet weak var numeroCartao: UITextField!
    @IBOutlet weak var nomeCartao: UITextField!
    @IBOutlet weak var validadeCartao: UITextField!
    @IBOutlet weak var imagemCartao: UIImageView!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var valor: UILabel!
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        usuario.load()
        
        numeroCartao.text = usuario.numeroCartao
        nomeCartao.text = usuario.nomeCartao
        validadeCartao.text = usuario.validadeCartao
        imagemCartao.image = CreditCardUtil().creditCardType(usuario.numeroCartao)
        valor.text = Formatadores().formatCurrency(value: valorTotal!)
        
        let validadeCartaoPickerView = ValidadeCartaoPickerView()
        validadeCartaoPickerView.onDateSelected = { (month: String, year: String) in
            self.validadeCartao.text = "\(month)/\(year)"
        }
        
        initializeInputAccessoryBar()
        
        validadeCartao.inputView = validadeCartaoPickerView
        validadeCartao.inputAccessoryView = inputAcessoryBar
    }
    
    @IBAction func escrevendoNumeroCartao(_ sender: UITextField) {
        imagemCartao.image = CreditCardUtil().creditCardType(sender.text!)
    }
    
    @IBAction func confirmarPagamento(_ sender: UIBarButtonItem) {
        if ( cvv.text == "" ) {
            let alerta = UIAlertController(title: "Erro...", message: "O código de verificação não pode ser vazio!", preferredStyle: .
                alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            navigationController?.present(alerta, animated: true, completion: nil)
        } else {
            let alerta = UIAlertController(title: "Confirmação", message: "Deseja confirmar o pagamento?", preferredStyle: .
                alert)
            alerta.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
            alerta.addAction(UIAlertAction(title: "Sim", style: .default, handler: {
                (UIAlertAction) in
                let dao = CarrinhoDao()
                dao.zeraCarrinho()
                dao.save()
                
                // Efetuar o pagamento no servidor
                
                self.navigationController?.popToRootViewController(animated: true)
            }))
            navigationController?.present(alerta, animated: true, completion: nil)
        }
    }
    
    func initializeInputAccessoryBar() {
        inputAcessoryBar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissSafraPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBar.items = [flexibleSpace, doneButton]
    }
    
    func dismissSafraPicker() {
        validadeCartao.resignFirstResponder()
    }
    
}
