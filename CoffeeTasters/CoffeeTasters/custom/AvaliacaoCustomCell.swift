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
    var vc: UIViewController?
    
    @IBAction func share(){
        let usuario = Usuario()
        usuario.load()
        
        let textoParaPublicar = "\(usuario.nome) avaliou um novo café: \(nomeCafe.text!) \n Avaliação: \(rating.rating)/4.0 \n"
        
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        vc?.setInitialText("Aonde isso vai?")

        let imageToShare = UIImage.init(view: flavor)
        vc?.add(imageToShare)
        
        vc?.add(URL(string: "http://www.coffeetasters.com.br/")!)
        vc?.setInitialText(textoParaPublicar)
        
        nav?.present(vc!, animated: true, completion: nil)

//        
//        
//        let photo = Photo(image: imageToShare, userGenerated: true)
//        let content = PhotoShareContent(photos: [photo])
//        
//        let shareDialog = ShareDialog(content: content)
//        shareDialog.mode = .native
//        shareDialog.failsOnInvalidData = true
//        shareDialog.completion = { result in
//            // Handle share results
//        }
//        
//        try? shareDialog.show()
        
    }
    
}
