//
//  DetalhesViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

class DetalhesViewController:UIViewController{
    
    var cafeAvaliado: Cafe?
    
    @IBOutlet var torradorLabel: UILabel?
    @IBOutlet var produtorLabel: UILabel?
    @IBOutlet var descricaoTextView: UITextView?
    @IBOutlet var rodaWheelFlavor: WheelFlavor?
    
    func cafeAvaliado(_ cafe: Cafe) {
        cafeAvaliado = cafe
    }
    
    override func viewDidLoad() {
        torradorLabel?.text = cafeAvaliado?.torrador
        produtorLabel?.text = cafeAvaliado?.produtor
        descricaoTextView?.text = cafeAvaliado?.descricao
        rodaWheelFlavor?.flavorTorrador = cafeAvaliado?.flavorTorrador
        rodaWheelFlavor?.setNeedsDisplay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "telaAvalia") {
            let view = segue.destination as! AvaliacaoViewController
            view.cafeAvaliado(cafeAvaliado!)
            //view.avaliacao.cafe = cafeAvaliado!
        }
        if(segue.identifier == "telaMapa") {
            let view = segue.destination as! MapaViewController
            view.setLocation(latitude: (cafeAvaliado?.latitude)!, longitude: (cafeAvaliado?.longitude)!)
        }
    }
    
}
