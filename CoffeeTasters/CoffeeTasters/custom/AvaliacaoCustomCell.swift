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
import FacebookShare

class AvaliacaoCustomCell: UITableViewCell {
    
    @IBOutlet weak var modoPrepado: UILabel!
    @IBOutlet weak var safra: UILabel!
    @IBOutlet weak var comentario: UITextView!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var nomeCafe: UILabel!
    
    var flavor: Flavor?
    var nav: UINavigationController?
    var vc: UIViewController?
    
    @IBAction func share(){
        let usuario = Usuario()
        usuario.load()
        
        let textoParaPublicar = "\(usuario.nome) avaliou \(nomeCafe.text!) \n Avaliação: \(rating.rating)/4.0 \n"
        
        let view = WheelFlavor(frame: CGRect(x: 0, y:0, width:300, height: 350))
        view.flavorUsuario = flavor
        view.textoParaPublicar = textoParaPublicar
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
//        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
//        vc?.add(image)
//        vc?.add(URL(string: "http://www.coffeetasters.com.br/")!)
//        vc?.setInitialText(textoParaPublicar)
//        nav?.present(vc!, animated: true, completion: nil)

  
        
//       let photo = Photo(image: image!, userGenerated: true)
//        let content = PhotoShareContent(photos: [photo])
        
//        let shareDialog = ShareDialog(content: content)
//        shareDialog.mode = .native
//        shareDialog.failsOnInvalidData = true
//        shareDialog.completion = { result in
//            // Handle share results
//        }
//
//
//        try? shareDialog.show()
        
        let activityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        nav?.present(activityViewController,animated: true,completion: nil)
        
    }
    
}
