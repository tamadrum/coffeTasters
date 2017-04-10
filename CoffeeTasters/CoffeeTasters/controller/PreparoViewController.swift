//
//  PreparoViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class PreparoViewController: UIViewController {
    
    @IBOutlet weak var imagemPreparo: UIImageView!
    @IBOutlet weak var descricaoPreparo: UITextView!
    @IBOutlet weak var tempo: UILabel!
    @IBOutlet weak var viewTemporizador: UIView!
    @IBOutlet weak var menuModos: UISegmentedControl!
    @IBOutlet weak var nomePreparoLabel: UILabel!
    
    var preparos = PreparoDao().getPreparo()
    var indice = 0
    
    override func viewDidLoad() {
        menuModos.removeAllSegments()
        
        for i in 0..<preparos.count {
            print("Adicionei \(i)" )
            let nomeImagem = preparos[i].imagem as! UIImage?
            menuModos.insertSegment(with: nomeImagem, at: i, animated: true)
        }
        
        menuModos.frame = CGRect(x: menuModos.frame.origin.x,y: menuModos.frame.origin.y, width: menuModos.frame.size.width,height: 50)
        
        menuModos.selectedSegmentIndex = 0;
        
        atualizaPasso()
    }
    
    @IBAction func tipoPreparo(_ sender: UISegmentedControl) {
        atualizaPasso()
    }
    
    func atualizaPasso() {
        let preparo = preparos[menuModos.selectedSegmentIndex]
        let passos = preparo.passo as! [Passo]
        
        var images:[UIImage] = []
        //for s in passos[indice].imagens! {
        //    images.append(s as! UIImage)
        //}
        
        var animatedImage: UIImage!
        animatedImage = UIImage.animatedImage(with: images, duration: 0.5)
        imagemPreparo.image = animatedImage
        
        descricaoPreparo.text = passos[indice].descricao
        nomePreparoLabel.text = preparo.nome
        viewTemporizador.isHidden = true

    }
    
    @IBAction func startTemporizador(_ sender: UIButton) {
    
    }
    
    @IBAction func stopTemporizador(_ sender: UIButton) {
    
    }
    
    @IBAction func proximo(_ sender: UIButton) {
        indice += 1
        if indice >= (preparos[menuModos.selectedSegmentIndex].passo?.count)! {
            indice = 0
        }
        atualizaPasso()
    }
    
    @IBAction func anterior(_ sender: Any) {
        indice -= 1
        if indice < 0 {
            indice = (preparos[menuModos.selectedSegmentIndex].passo?.count)! - 1
        }
        atualizaPasso()
    }

}
