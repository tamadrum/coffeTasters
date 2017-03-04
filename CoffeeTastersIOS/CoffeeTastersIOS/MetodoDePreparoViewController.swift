//
//  MetodoDePreparoViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class MetodoDePreparoViewController:UIViewController {
    
    @IBOutlet var modoPreparoLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descricaoTextView: UITextView!
    @IBOutlet var menuModos: UISegmentedControl!
    @IBAction func proximoPasso(_ sender: Any) {
        
        indice += 1
        if indice >= (metodoPreparo[menuModos.selectedSegmentIndex].passos?.count)! {
            indice = 0
        }
        atualizaPasso()
        
    }
    @IBAction func anteriorPasso(_ sender: Any) {
        
        indice -= 1
        if indice < 0 {
            indice = (metodoPreparo[menuModos.selectedSegmentIndex].passos?.count)! - 1
        }
        atualizaPasso()
        
    }
    
    var metodoPreparo = PreparaDao().getPreparo()
    var indice = 0
    
    
    override func viewDidLoad() {
        
        menuModos.frame = CGRect(x: menuModos.frame.origin.x,y: menuModos.frame.origin.y, width: menuModos.frame.size.width,height: 50)
        
        menuModos.addTarget(self, action: #selector(changeModo), for: .valueChanged)
        
        atualizaPasso()
        
    }
    
    func changeModo() {
    
        print(menuModos.selectedSegmentIndex)
        atualizaPasso()
        
        
    }
    
    func atualizaPasso() {
    
        let images = metodoPreparo[menuModos.selectedSegmentIndex].passos?[indice].getImagens()
        
        var animatedImage: UIImage!
        animatedImage = UIImage.animatedImage(with: images!, duration: 0.5)
        imageView.image = animatedImage
        
        descricaoTextView.text = metodoPreparo[menuModos.selectedSegmentIndex].passos?[indice].descricao
        modoPreparoLabel.text = metodoPreparo[menuModos.selectedSegmentIndex].passos?[indice].tipo
    }
    
    
}
