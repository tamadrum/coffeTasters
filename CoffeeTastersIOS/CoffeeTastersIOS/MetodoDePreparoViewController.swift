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
    
    var preparos = PreparaDao().getPreparo()
    var indice = 0
    
    @IBAction func proximoPasso(_ sender: Any) {
        indice += 1
        if indice >= (preparos[menuModos.selectedSegmentIndex].passo?.count)! {
            indice = 0
        }
        atualizaPasso()
    }
    
    @IBAction func anteriorPasso(_ sender: Any) {
        indice -= 1
        if indice < 0 {
            indice = (preparos[menuModos.selectedSegmentIndex].passo?.count)! - 1
        }
        atualizaPasso()
    }

    override func viewDidLoad() {
        menuModos.removeAllSegments()
        
        for i in 0..<preparos.count {
            print("Adicionei \(i)" )
            menuModos.insertSegment(with: UIImage(named: preparos[i].imagem!), at: i, animated: true)
        }
        
        menuModos.frame = CGRect(x: menuModos.frame.origin.x,y: menuModos.frame.origin.y, width: menuModos.frame.size.width,height: 50)

        menuModos.addTarget(self, action: #selector(atualizaPasso), for: .valueChanged)
        menuModos.selectedSegmentIndex = 0;
        atualizaPasso()
    }
    
    func atualizaPasso() {
        let preparo = preparos[menuModos.selectedSegmentIndex]
        let passos = preparo.passo?.allObjects as! [Passo]
        let imagesString = passos[indice].imagens
        var images:[UIImage] = []
        
        for s in imagesString! {
            images.append(UIImage(named: s as! String)!)
        }
        
        var animatedImage: UIImage!
        animatedImage = UIImage.animatedImage(with: images, duration: 0.5)
        imageView.image = animatedImage
        
        descricaoTextView.text = passos[indice].descricao
        modoPreparoLabel.text = preparo.nome
    }
    
    
}
