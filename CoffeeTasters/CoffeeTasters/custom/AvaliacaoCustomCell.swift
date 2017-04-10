//
//  AvaliacaoCustomCell.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import Social

class AvaliacaoCustomCell: UITableViewCell {
    
    @IBOutlet weak var modoPrepado: UILabel!
    @IBOutlet weak var safra: UILabel!
    @IBOutlet weak var comentario: UITextView!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var flavor: WheelFlavor!
    @IBOutlet weak var nomeCafe: UILabel!
    
    var nav: UINavigationController!
    var imagem: UIImage!
    
    @IBAction func share(_ sender: UIButton) {
        let usuario = Usuario()
        usuario.load()
        let textoParaPublicar = "\(usuario.nome) avaliou um novo café: \n \(nomeCafe.text!) \n Avaliação: \(rating.rating) \n"
        imagem = UIImage.init(view: flavor)
        
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        vc?.setInitialText("Aonde isso vai?")
        vc?.add(imagem)
        vc?.add(URL(string: "http://www.coffeetasters.com.br/")!)
        vc?.setInitialText(textoParaPublicar)
        
        nav.present(vc!, animated: true, completion: nil)
        
    }
    
}
