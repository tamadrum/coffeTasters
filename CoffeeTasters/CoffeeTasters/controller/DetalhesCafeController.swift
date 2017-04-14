//
//  DetalhesCafeController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class DetalhesCafeController: UIViewController {
    
    @IBOutlet weak var torradorLabel: UILabel!
    @IBOutlet weak var produtorLabel: UILabel!
    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var cidadeLabel: UILabel!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var tipoCafeLabel: UILabel!
    @IBOutlet weak var alturaLabel: UILabel!
    @IBOutlet weak var safraLabel: UILabel!
    @IBOutlet weak var comentarioTextView: UITextView!
    @IBOutlet weak var notaQuatroLabel: UILabel!
    @IBOutlet weak var notaTresLabel: UILabel!
    @IBOutlet weak var notaDoisLabel: UILabel!
    @IBOutlet weak var notaUmLabel: UILabel!
    @IBOutlet weak var rodaSabores: WheelFlavor!
    @IBOutlet weak var torradorMediaSegmentControl: UISegmentedControl!
    @IBOutlet weak var avaliacoesAntigasSegmentControl: UISegmentedControl!
    
    var cafeAvaliado: Cafe!
    
    override func viewDidLoad() {
        torradorLabel.text = cafeAvaliado.torrador
        produtorLabel.text = cafeAvaliado.produtor
        paisLabel.text = cafeAvaliado.pais
        cidadeLabel.text = cafeAvaliado.cidade
        estadoLabel.text = cafeAvaliado.estado
        tipoCafeLabel.text = cafeAvaliado.tipo
        alturaLabel.text = "\(cafeAvaliado.altitude)m"
        safraLabel.text = cafeAvaliado.safra
        comentarioTextView.text = cafeAvaliado.descricao
        notaQuatroLabel.text = "10"
        notaTresLabel.text = "20"
        notaDoisLabel.text = "30"
        notaUmLabel.text = "0"
        rodaSabores.flavorUsuario = cafeAvaliado.flavorTorrador
        
        title = cafeAvaliado.nome
        
    }
    
    @IBAction func avaliacaoComCafePopulado() {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "avaliacao") as! AvaliacaoViewController
        
        view.cafeAvaliado = cafeAvaliado
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func verMapa(_ sender: UIButton) {
        let url = ("https://www.google.com.br/maps/@-23.5837048,-46.5731714,17z?hl=pt-BR").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        if !UIApplication.shared.canOpenURL(URL(string: url)!) {
            print("Não posso abrir... :-(")
        } else {
            UIApplication
                .shared // Pode usar o canOpen também... mas tem que testar em todo o canto...
                .open(URL(string: url)!, options: [:], completionHandler: {
                    (x: Bool) in
                    print("open url voltou com \(x)")
                })
        }
        
    }
    
    @IBAction func comprarCafe(_ sender: Any) {
        print("Comprar café")
    }
}
