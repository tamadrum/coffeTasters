//
//  CafeDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CafeDao {

    var managedContext: NSManagedObjectContext?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func newCafe() -> Cafe {
        return NSEntityDescription.insertNewObject(forEntityName: "CDCafe", into: managedContext!) as! Cafe
    }

    var data = ["Café Camacho", "Puro Sabor", "Café União", "Café 262", "Bedê", "Piloão de Minas",
                "Uno", "Bom Despacho", "Café Jardim", "Caboclo", "Café Maratá", "Café Brasileiro", "Qualitá", "Café Bom Jesus", "Seleto", "3 Corações", "Café Fort",
                "Café do Ponto", "Café Pimpinela", "Café Pelé", "Melitta", "Pilão"]
    
    func getListaCafe( ) -> [Cafe] {
        var retorno: [Cafe] = []
        
        let calendario = Calendar.current
        
        let dataDaColheita = DateComponents(year: 2020, month: 4, day: 10)
        let dataDaTorra = DateComponents(year: 2030, month: 10, day: 20)
        
        let cafe = newCafe()
        cafe.dataColheita = calendario.date(from: dataDaColheita)! as NSDate?
        cafe.dataTorra = calendario.date(from: dataDaTorra)! as NSDate?
        cafe.nome = "Café Pelé"
        cafe.origem = "Afeganistão"
        cafe.produtor = "Asdrubal"
        cafe.torrador = "Epaminondas"
        cafe.descricao = "dfjks JKS SLKJg fzsjgdf lJKSGHDc zsbdjhvg zskjdf ljBSDfj gas,db jg"
        cafe.imagem = "cafe.jpg"
        cafe.flavorTorrador = FlavorDao().newFlavor()
        cafe.flavorTorrador?.amargo = 1
        cafe.flavorTorrador?.azedo = 5
        cafe.flavorTorrador?.caramelo = 6
        cafe.flavorTorrador?.cereais = 5
        cafe.flavorTorrador?.chocolate = 6
        cafe.flavorTorrador?.defumado = 2
        cafe.flavorTorrador?.doce = 7
        cafe.flavorTorrador?.encorpado = 5
        cafe.flavorTorrador?.especiarias = 7
        cafe.flavorTorrador?.floral = 3
        cafe.flavorTorrador?.frutasCaroco = 8
        cafe.flavorTorrador?.frutasCitricas = 5
        cafe.flavorTorrador?.frutasVermelhas = 8
        cafe.flavorTorrador?.herbal = 4
        cafe.flavorTorrador?.nozes = 9
        cafe.flavorTorrador?.salgado = 9
        
        retorno.append(cafe)
        
        return retorno
    }
    
    func getLista() -> [Cafe] {
        var retorno:[Cafe] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCafe")
        
        do {
            retorno = try managedContext?.fetch(fetchRequest) as! [Cafe]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return retorno
    }
    
    func save() {
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
