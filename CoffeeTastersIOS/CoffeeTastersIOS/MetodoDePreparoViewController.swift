//
//  MetodoDePreparoViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class MetodoDePreparoViewController:UIViewController{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descricaoTextView: UITextView!
    @IBOutlet var menuModos: UISegmentedControl!
    
    var metodoPreparo = PreparaDao().getPreparo()
    
    
    
    override func viewDidLoad() {
        
        menuModos.frame = CGRect(x: menuModos.frame.origin.x,y: menuModos.frame.origin.y, width: menuModos.frame.size.width,height: 50)
        
        
        var img = UIImage(contentsOfFile: metodoPreparo.passos[0].imagens[0])
        
        
        
    }
    
    
}
