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
    @IBOutlet weak var metodoSegmentControl: UISegmentedControl!
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
        
        if Bool(cafeAvaliado.metodo) == true {
            self.metodoSegmentControl.selectedSegmentIndex = 1
        } else {
            self.metodoSegmentControl.selectedSegmentIndex = 0
        }
        metodoSegmentControl.isUserInteractionEnabled = false
        
        comentarioTextView.text = cafeAvaliado.descricao
        notaQuatroLabel.text = "10"
        notaTresLabel.text = "20"
        notaDoisLabel.text = "30"
        notaUmLabel.text = "0"
        
        let avaliacoes = Dao<Avaliacao>().list()
        
        for a in avaliacoes {
            
            if a.cafe?.nome == cafeAvaliado.nome {
                
                rodaSabores.flavorUsuario = a.flavor
                
            }
            
        }
        
        //rodaSabores.flavorUsuario = cafeAvaliado.flavorTorrador
//        rodaSabores.flavorTorrador = Dao<Flavor>().new()
//        
//        rodaSabores.flavorTorrador?.amargo = 8
//        rodaSabores.flavorTorrador?.azedo = 2
//        rodaSabores.flavorTorrador?.caramelo = 2
//        rodaSabores.flavorTorrador?.cereais = 1
//        rodaSabores.flavorTorrador?.chocolate = 6
//        rodaSabores.flavorTorrador?.defumado = 9
//        rodaSabores.flavorTorrador?.doce = 6
//        rodaSabores.flavorTorrador?.encorpado = 3
//        rodaSabores.flavorTorrador?.especiarias = 2
//        rodaSabores.flavorTorrador?.floral = 7
//        rodaSabores.flavorTorrador?.frutasCaroco = 9
//        rodaSabores.flavorTorrador?.frutasCitricas = 1
//        rodaSabores.flavorTorrador?.frutasVermelhas = 3
//        rodaSabores.flavorTorrador?.herbal = 8
//        rodaSabores.flavorTorrador?.nozes = 9
//        rodaSabores.flavorTorrador?.salgado = 3
        
        title = cafeAvaliado.nome
        
    }
    
    @IBAction func avaliacaoComCafePopulado() {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "avaliacao") as! AvaliacaoViewController
        
        view.cafeAvaliado = cafeAvaliado
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func verMapa(_ sender: UIButton) {
        let stringUrl = "https://www.google.com.br/maps/@\(cafeAvaliado.latitude),\(cafeAvaliado.longitude),17z?hl=pt-BR"
        print(stringUrl)
        let url = (stringUrl).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
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
    
    @IBAction func mostraMediaTorrador(_ sender: UISegmentedControl) {
        // Ou mostra torrador, ou mostra media
        
        if ( sender.selectedSegmentIndex == 0 ) {
            print("trocou \(sender.selectedSegmentIndex)")
            rodaSabores.flavorTorrador = Dao<Flavor>().new()
            rodaSabores.flavorMedia = nil
            
            rodaSabores.flavorTorrador?.amargo = 8
            rodaSabores.flavorTorrador?.azedo = 2
            rodaSabores.flavorTorrador?.caramelo = 2
            rodaSabores.flavorTorrador?.cereais = 1
            rodaSabores.flavorTorrador?.chocolate = 6
            rodaSabores.flavorTorrador?.defumado = 9
            rodaSabores.flavorTorrador?.doce = 6
            rodaSabores.flavorTorrador?.encorpado = 3
            rodaSabores.flavorTorrador?.especiarias = 2
            rodaSabores.flavorTorrador?.floral = 7
            rodaSabores.flavorTorrador?.frutasCaroco = 9
            rodaSabores.flavorTorrador?.frutasCitricas = 1
            rodaSabores.flavorTorrador?.frutasVermelhas = 3
            rodaSabores.flavorTorrador?.herbal = 8
            rodaSabores.flavorTorrador?.nozes = 9
            rodaSabores.flavorTorrador?.salgado = 3
        } else {
            print("trocou \(sender.selectedSegmentIndex)")
            rodaSabores.flavorMedia = Dao<Flavor>().new()
            rodaSabores.flavorTorrador = nil
            
            rodaSabores.flavorMedia?.amargo = 4
            rodaSabores.flavorMedia?.azedo = 3
            rodaSabores.flavorMedia?.caramelo = 7
            rodaSabores.flavorMedia?.cereais = 9
            rodaSabores.flavorMedia?.chocolate = 3
            rodaSabores.flavorMedia?.defumado = 1
            rodaSabores.flavorMedia?.doce = 6
            rodaSabores.flavorMedia?.encorpado = 8
            rodaSabores.flavorMedia?.especiarias = 3
            rodaSabores.flavorMedia?.floral = 4
            rodaSabores.flavorMedia?.frutasCaroco = 5
            rodaSabores.flavorMedia?.frutasCitricas = 5
            rodaSabores.flavorMedia?.frutasVermelhas = 9
            rodaSabores.flavorMedia?.herbal = 3
            rodaSabores.flavorMedia?.nozes = 1
            rodaSabores.flavorMedia?.salgado = 7
        }
        rodaSabores.setNeedsDisplay()
        
    }
    
    @IBAction func mostraUltimasAvaliacoes(_ sender: UISegmentedControl) {
        
//        let usuario = Usuario()
//        usuario.load()
        let avaliacoes = Dao<Avaliacao>().list()
        
        for a in avaliacoes {
            
            if a.cafe?.nome == cafeAvaliado.nome {
            
                rodaSabores.flavorUsuario = a.flavor
                
            }
            
        }
        
    }
    
}
