//
//  AvaliacaoViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit
import Foundation
import FBSDKShareKit
import Social

class AvaliacaoViewController:UIViewController, UpdateFlavorUsuario {
    
    @IBOutlet weak var gostouRatingView: RatingView?
    @IBOutlet weak var rodaWheelFlavor: WheelFlavor?

    var avaliacao: Avaliacao!

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var torradorLabel: UILabel!
    @IBOutlet weak var produtorLabel: UILabel!
    
    var toggleComentario: Bool = false
    
    @IBOutlet var notasView: UIView!
    @IBOutlet var auxView: UIView!
    @IBOutlet var notasTextView: UITextView!
    
//    
//    let calendario = NSCalendar.current
//    
//    let dataDaColheita = NSDateComponents()
//    dataDaColheita.day = 10
//    dataDaColheita.month = 10
//    dataDaColheita.year = 2017
//    
//    let dataDaTorra = NSDateComponents()
//    dataDaTorra.day = 5
//    dataDaTorra.month = 5
//    dataDaTorra.year = 2017
//    
//    cafe.dataColheita = calendario.date(from: dataDaColheita as DateComponents)! as NSDate?
//    cafe.dataTorra = calendario.date(from: dataDaTorra as DateComponents)! as NSDate?
    
    
    
    
    func cafeAvaliado(_ cafe: Cafe) {
        avaliacao = AvaliacoesDao().newAvaliacao()
        
        self.avaliacao.cafe = cafe
        
        avaliacao.flavor = FlavorDao().newFlavor()
        avaliacao.flavorMedia = FlavorDao().newFlavor()
        avaliacao.flavorMedia?.doce = 5
        avaliacao.flavorMedia?.azedo = 10
        avaliacao.flavorMedia?.floral = 5
        avaliacao.flavorMedia?.especiarias = 10
        avaliacao.flavorMedia?.salgado = 5
        avaliacao.flavorMedia?.frutasVermelhas = 10
        avaliacao.flavorMedia?.frutasCitricas = 5
        avaliacao.flavorMedia?.frutasCaroco = 10
        avaliacao.flavorMedia?.chocolate = 5
        avaliacao.flavorMedia?.caramelo = 10
        avaliacao.flavorMedia?.defumado = 5
        avaliacao.flavorMedia?.amargo = 10
        avaliacao.flavorMedia?.herbal = 5
        avaliacao.flavorMedia?.encorpado = 10
        avaliacao.flavorMedia?.cereais = 5
        avaliacao.flavorMedia?.nozes = 10
    }
    
    override func viewDidLoad() {
        self.nomeLabel?.text = self.avaliacao.cafe?.nome
        self.torradorLabel?.text = self.avaliacao.cafe?.torrador
        self.produtorLabel?.text = self.avaliacao.cafe?.produtor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let cancelar = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(sairSemSalvar))
        navigationItem.leftBarButtonItem = cancelar
        
    }
    
    func sairSemSalvar () {
        print("saindo sem salvar")
        
        AvaliacoesDao().managedContext?.reset()
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func mostraTorrador(_ sender: Any) {
        if rodaWheelFlavor?.flavorTorrador == nil {
            rodaWheelFlavor?.flavorTorrador = self.avaliacao.cafe?.flavorTorrador
        } else {
            rodaWheelFlavor?.flavorTorrador = nil
        }
        rodaWheelFlavor?.setNeedsDisplay()
    }
    
    @IBAction func mostraMedia(_ sender: Any) {
        if rodaWheelFlavor?.flavorMedia == nil {
            rodaWheelFlavor?.flavorMedia = avaliacao.flavorMedia
        } else {
            rodaWheelFlavor?.flavorMedia = nil
        }
        rodaWheelFlavor?.setNeedsDisplay()
    }
    
    @IBAction func share(_ sender: Any) {
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        //vc.add(image: UIImage(named: "config")!)
        vc?.add(URL(string: "http://www.example.com/"))
        vc?.setInitialText("Initial text here.")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func salvar(_ sender: Any) {
        avaliacao.gostou = Int16((gostouRatingView?.rating)!)
        
        AvaliacoesDao().save()
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    @IBAction func toggleNotal(_ sender: Any) {
        
//        let alert = UIAlertController(title: "Notas",
//                                      message: "Adicionar uma observação a sua avaliação",
//                                      preferredStyle: .alert)
//        
//        let submitAction = UIAlertAction(title: "Adicionar", style: .default, handler: { (action) -> Void in
//            
//            let textField = alert.textFields![0]
//            
//            self.avaliacao.obs = (textField.text)!
//            
//            self.avaliacao.obs = textField.text
//        })
//        
//        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action) -> Void in })
//        
//        alert.addTextField { (textField: UITextField) in
//            textField.keyboardType = .default
//            textField.autocorrectionType = .default
//            textField.placeholder = "Digite suas observações aqui"
//            textField.clearButtonMode = .whileEditing
//            textField.text = self.avaliacao.obs
//        }
//        
//        
//        alert.addAction(submitAction)
//        alert.addAction(cancel)
//        
//        present(alert, animated: true, completion: nil)

        if toggleComentario == false {
            
            UIView.animate(withDuration: 0.5, animations: {
                // self.ratingDetailsView.frame.origin.y = self.totalRating.frame.origin.y - self.totalRating.frame.size.height + self.ratingDetailsView.frame.size.height/2
                self.notasView.frame.origin.y = self.auxView.frame.origin.y + self.auxView.frame.size.height
                
                
            })
            notasTextView.text = self.avaliacao.obs
            toggleComentario = true
            
        } else {
            
            UIView.animate(withDuration: 0.5, animations: {
                //self.ratingDetailsView.frame.origin.y = self.totalRating.frame.origin.y - self.totalRating.frame.size.height - self.ratingDetailsView.frame.size.height/2
                //self.ratingDetailsView.frame.origin.y = self.auxView.frame.origin.y - self.ratingDetailsView.frame.size.height/2
                self.notasView.frame.origin.y = self.notasView.frame.origin.y - self.notasView.frame.size.height
                
            })
            self.avaliacao.obs = notasTextView.text
            toggleComentario = false
            
        }

    
    
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "telaRoda" ) {
            let view = segue.destination as! FlavorViewController
            view.delegate = self
            view.flavor = avaliacao.flavor
        }
    }
    
    func updateFlavor(flavor: Flavor){
        avaliacao.flavor = flavor
        
        rodaWheelFlavor?.flavorUsuario = flavor
        rodaWheelFlavor?.setNeedsDisplay()
    }
}
