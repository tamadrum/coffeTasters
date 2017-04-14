//
//  PreparoViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PreparoViewController: UIViewController {
    
    @IBOutlet weak var imagemPreparo: UIImageView!
    @IBOutlet weak var descricaoPreparo: UITextView!
    @IBOutlet weak var tempo: UILabel!
    @IBOutlet weak var viewTemporizador: UIView!
    @IBOutlet weak var menuModos: UISegmentedControl!
    @IBOutlet weak var nomePreparoLabel: UILabel!
    
    var preparos = Dao<Preparo>().list()
    var indice = 0
    var timer = Timer()
    var segundos: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        
        menuModos.removeAllSegments()
        
        for i in 0..<preparos.count {
            let nomeImagem = preparos[i].imagem as! UIImage?
            menuModos.insertSegment(with: nomeImagem, at: i, animated: true)
        }
        
        menuModos.frame = CGRect(x: menuModos.frame.origin.x,y: menuModos.frame.origin.y, width: menuModos.frame.size.width,height: 50)
        
        menuModos.selectedSegmentIndex = 0;
        
        atualizaPasso()
    }
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func tipoPreparo(_ sender: UISegmentedControl) {
        indice = 0
        atualizaPasso()
    }
    
    func atualizaPasso() {
        if ( preparos.count > 0 ) {
            let preparo = preparos[menuModos.selectedSegmentIndex]
            let passos = preparo.passo?.allObjects as! [Passo]
            
            var images:[UIImage] = []
            for s in passos[indice].imagens! {
                images.append(s as! UIImage)
            }
            
            var animatedImage: UIImage!
            animatedImage = UIImage.animatedImage(with: images, duration: 0.5)
            imagemPreparo.image = animatedImage
            
            descricaoPreparo.text = passos[indice].descricao
            nomePreparoLabel.text = preparo.nome
            if ( passos[indice].tempo > 0 ) {
                viewTemporizador.isHidden = false
                segundos = Int(passos[indice].tempo)
                tempo.text = timeString(segundos)
            } else {
                viewTemporizador.isHidden = true
            }
        }
    }
    
    @IBAction func startTemporizador(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    func updateTimer () {
        if ( segundos > 0 ) {
            segundos = segundos - 1
        } else {
            let systemSoundID: SystemSoundID = 1025
            AudioServicesPlaySystemSound (systemSoundID)
            timer.invalidate()
        }
        tempo.text = timeString(segundos)
    }
    
    @IBAction func stopTemporizador(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func proximo(_ sender: UIButton) {
        indice += 1
        if indice >= (preparos[menuModos.selectedSegmentIndex].passo?.count)! {
            indice = 0
        }
        timer.invalidate()
        atualizaPasso()
    }
    
    @IBAction func anterior(_ sender: Any) {
        indice -= 1
        if indice < 0 {
            indice = (preparos[menuModos.selectedSegmentIndex].passo?.count)! - 1
        }
        timer.invalidate()
        atualizaPasso()
    }
    
    func timeString(_ tempo:Int)  -> String {
        let minutes = tempo / 60
        let seconds = tempo % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }

}
