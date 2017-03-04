//
//  FlavorViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

protocol UpdateFlavorUsuario{
    func updateFlavor(flavor: Flavor)
}

class FlavorViewController:UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView?
    var delegate: UpdateFlavorUsuario?
    var flavor: Flavor?
    
    var labels = ["Doce", "Azedo", "Floral", "Especiarias", "Salgado", "Frutas Vermelhas", "Frutas Cítricas", "Frutas Caroço", "Chocolate", "Caramelo", "Defumado", "Amargo", "Herbal", "Encorpado", "Cereais", "Nozes"]

    @IBAction func salvar(_ sender: Any) {
        delegate?.updateFlavor(flavor: self.flavor!)
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath) as! FlavorCustomViewCell
        cell.flavor?.text = labels[indexPath.row]
        
        if let flavor = self.flavor {
            
        
        switch labels[indexPath.row] {
        case "Doce":
            cell.valor?.value = Float((flavor.doce))
            cell.valor?.restorationIdentifier = "Doce"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Azedo":
            cell.valor?.value = Float((flavor.azedo))
            cell.valor?.restorationIdentifier = "Azedo"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Floral":
            cell.valor?.value = Float((flavor.floral))
            cell.valor?.restorationIdentifier = "Floral"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Especiarias":
            cell.valor?.value = Float((flavor.especiarias))
            cell.valor?.restorationIdentifier = "Especiarias"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Salgado":
            cell.valor?.value = Float((flavor.salgado))
            cell.valor?.restorationIdentifier = "Salgado"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Frutas Vermelhas":
            cell.valor?.value = Float((flavor.frutasVermelhas))
            cell.valor?.restorationIdentifier = "Frutas Vermelhas"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Frutas Cítricas":
            cell.valor?.value = Float((flavor.frutasCitricas))
            cell.valor?.restorationIdentifier = "Frutas Cítricas"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Frutas Caroço":
            cell.valor?.value = Float((flavor.frutasCaroco))
            cell.valor?.restorationIdentifier = "Frutas Caroço"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Chocolate":
            cell.valor?.value = Float((flavor.chocolate))
            cell.valor?.restorationIdentifier = "Chocolate"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Caramelo":
            cell.valor?.value = Float((flavor.caramelo))
            cell.valor?.restorationIdentifier = "Caramelo"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Defumado":
            cell.valor?.value = Float((flavor.defumado))
            cell.valor?.restorationIdentifier = "Defumado"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Amargo":
            cell.valor?.value = Float((flavor.amargo))
            cell.valor?.restorationIdentifier = "Amargo"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Herbal":
            cell.valor?.value = Float((flavor.herbal))
            cell.valor?.restorationIdentifier = "Herbal"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Encorpado":
            cell.valor?.value = Float((flavor.encorpado))
            cell.valor?.restorationIdentifier = "Encorpado"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Cereais":
            cell.valor?.value = Float((flavor.cereais))
            cell.valor?.restorationIdentifier = "Cereais"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        case "Nozes":
            cell.valor?.value = Float((flavor.nozes))
            cell.valor?.restorationIdentifier = "Nozes"
            cell.valor?.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
            break
        default:
            break
        }
        cell.valor?.addTarget(self, action: #selector(mudouSlider), for: .valueChanged)

        }
        return cell
    }

    func mudouSlider(sender: UISlider){
        let nome = sender.restorationIdentifier!
        if let flavor = self.flavor {
            
        switch nome {
        case "Doce":
            flavor.doce = Int32(Int(sender.value))
            break
        case "Azedo":
            flavor.azedo = Int32(sender.value)
            break
        case "Floral":
            flavor.floral = Int32(sender.value)
            break
        case "Especiarias":
            flavor.especiarias = Int32(sender.value)
            break
        case "Salgado":
            flavor.salgado = Int32(sender.value)
            break
        case "Frutas Vermelhas":
            flavor.frutasVermelhas = Int32(sender.value)
            break
        case "Frutas Cítricas":
            flavor.frutasCitricas = Int32(sender.value)
            break
        case "Frutas Caroço":
            flavor.frutasCaroco = Int32(sender.value)
            break
        case "Chocolate":
            flavor.chocolate = Int32(sender.value)
            break
        case "Caramelo":
            flavor.caramelo = Int32(sender.value)
            break
        case "Defumado":
            flavor.defumado = Int32(sender.value)
            break
        case "Amargo":
            flavor.amargo = Int32(sender.value)
            break
        case "Herbal":
            flavor.herbal = Int32(sender.value)
            break
        case "Encorpado":
            flavor.encorpado = Int32(sender.value)
            break
        case "Cereais":
            flavor.cereais = Int32(sender.value)
            break
        case "Nozes":
            flavor.nozes = Int32(sender.value)
            break
        default:
            break
        }
        }
    }
    
}
