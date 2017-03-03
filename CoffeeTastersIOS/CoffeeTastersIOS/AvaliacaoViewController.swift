//
//  AvaliacaoViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import Foundation

class AvaliacaoViewController:UIViewController, UpdateFlavorUsuario {
    
    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var torradorTextField: UITextField?
    @IBOutlet weak var produtorTextField: UITextField?
    @IBOutlet weak var comentarioTextView: UITextView?
    @IBOutlet weak var gostouRatingView: RatingView?
    @IBOutlet weak var rodaWheelFlavor: WheelFlavor?

    var cafeAvaliado: Cafe?
    var avaliacao = Avaliacao()
    
    func cafeAvaliado(_ cafe: Cafe) {
        self.cafeAvaliado = cafe
    }
    
    override func viewDidLoad() {
        self.nomeTextField?.text = cafeAvaliado?.nome
        self.torradorTextField?.text = cafeAvaliado?.torrador
        self.produtorTextField?.text = cafeAvaliado?.produtor
    }

    @IBAction func mostraTorrador(_ sender: Any) {
        if rodaWheelFlavor?.flavorTorrador == nil {
            rodaWheelFlavor?.flavorTorrador = cafeAvaliado?.flavor
        } else {
            rodaWheelFlavor?.flavorTorrador = Flavor()
        }
        rodaWheelFlavor?.setNeedsDisplay()
    }
    
    @IBAction func mostraMedia(_ sender: Any) {
        if rodaWheelFlavor?.flavorMedia == nil {
            rodaWheelFlavor?.flavorMedia = avaliacao.flavorMedia
        } else {
            rodaWheelFlavor?.flavorMedia = Flavor()
        }
        rodaWheelFlavor?.setNeedsDisplay()
    }
    
    @IBAction func share(_ sender: Any) {
    }
    
    @IBAction func salvar(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "telaRoda" ) {
            let view = segue.destination as! FlavorViewController
            view.flavor = avaliacao.flavor
            view.delegate = self
        }
    }
    
    func updateFlavor(flavor: Flavor){
        avaliacao.flavor = flavor
        
        rodaWheelFlavor?.flavorUsuario = flavor
        rodaWheelFlavor?.setNeedsDisplay()
    }
}
