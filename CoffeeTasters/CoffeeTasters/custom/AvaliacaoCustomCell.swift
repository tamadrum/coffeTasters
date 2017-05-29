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
    @IBOutlet weak var nomeCafe: UILabel!
    
    var flavor: WheelFlavor!
    var nav: UINavigationController?
    
    @IBAction func share(){
        let usuario = Usuario()
        usuario.load()
        
        //let imageToShare = UIImage.init(view: flavor)
        
        let textoParaPublicar = "\(usuario.nome) avaliou um novo café: \(nomeCafe.text!) \n Avaliação: \(rating.rating)/4.0 \n"
        
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        vc?.setInitialText("Aonde isso vai?")
        //vc?.add(imageToShare)
        vc?.add(URL(string: "http://www.coffeetasters.com.br/")!)
        vc?.setInitialText(textoParaPublicar)
        
        nav?.present(vc!, animated: true, completion: nil)
    }
    
}
