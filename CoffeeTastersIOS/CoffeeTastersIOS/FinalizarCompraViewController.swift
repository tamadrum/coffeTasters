//
//  FinalizarCompraViewController.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class FinalizarCompraViewController: UIViewController {
    
    @IBOutlet weak var numeroTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var validadeTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var tipoCartaoImage: UIImageView!
    @IBOutlet weak var valorTotalLabel: UILabel!
    
    override func viewDidLoad() {
        let usuario = Usuario()
        usuario.load()
        
        numeroTextField.text = usuario.numeroCartao
        nomeTextField.text = usuario.nomeCartao
        validadeTextField.text = usuario.validadeCartao
        
        valorTotalLabel.text = "R$ \(CarrinhoDao().getValorCarrinho())"
        
        tipoCartaoImage.image = CreditCardUtil().creditCardType(usuario.numeroCartao)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pagar", style: .plain, target: self, action: #selector(pagar))
    }
    
    func pagar () {
        let alerta = UIAlertController(title: "Pagamento sendo efetuado...", message: "Acompanhe o paragento pela tela de pedidos", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            CarrinhoDao().zeraCarrinho()
            
            if let nav = self.navigationController {
                nav.popToRootViewController(animated: true)
            }
        })
        alerta.addAction(ok)
        
        navigationController?.present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func escreveuNumeroCartao(_ sender: UITextField) {
        tipoCartaoImage.image = CreditCardUtil().creditCardType(sender.text!)
    }
    
}
