//
//  Dao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Dao<T> {
    
    var banco:String?
    var managedContext: NSManagedObjectContext!
    
    init() {
        if type(of: T.self) == type(of: Avaliacao.self) {
            banco = "Avaliacao"
        } else if type(of: T.self) == type(of: Cafe.self) {
            banco = "Cafe"
        } else if type(of: T.self) == type(of: Item.self) {
            banco = "Item"
        } else if type(of: T.self) == type(of: Pedido.self) {
            banco = "Pedido"
        } else if type(of: T.self) == type(of: Produto.self) {
            banco = "Produto"
        } else if type(of: T.self) == type(of: Carrinho.self) {
            banco = "Carrinho"
        } else if type(of: T.self) == type(of: Flavor.self) {
            banco = "Flavor"
        } else if type(of: T.self) == type(of: Passo.self) {
            banco = "Passo"
        } else if type(of: T.self) == type(of: Preparo.self) {
            banco = "Preparo"
        } else if type(of: T.self) == type(of: Imagens.self) {
            banco = "Imagens"
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }
        
    }
    
    func new() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: banco!,
                                                   into: managedContext) as! T
    }
    
    func list() -> [T] {
        var retorno:[T] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
        
        do {
            retorno = try managedContext.fetch(fetchRequest) as! [T]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return retorno
    }

    func delete(_ obj: NSManagedObject) {
        managedContext.delete(obj)
    }
    
    func reset () {
        managedContext.reset()
    }
    
    func save () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Impossível salvar... \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func count() -> Int {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
            
            let count = try managedContext.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            return 0
        }
    }
    
    func inserirDadosIniciais () {
        print("**************************")
        print("inserindo dados iniciais")
        print("**************************")
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        if !dadosInseridos {
            
            // Inserindo Produtos
                
                let prod1:Produto = Dao<Produto>().new()
                prod1.nome = "Café Pelé"
                prod1.preco = 10
                prod1.tipo = "Café"
                prod1.oferta = true
                prod1.precoOferta = 9
                prod1.descricao = "Descrição do Café"
                
                let prod2 = Dao<Produto>().new()
                prod2.nome = "Café Pilão"
                prod2.preco = 20
                prod2.tipo = "Café"
                prod2.oferta = false
                prod2.descricao = "Descrição do Café"
                
                let prod3 = Dao<Produto>().new()
                prod3.nome = "3 Corações"
                prod3.preco = 30
                prod3.tipo = "Café"
                prod3.oferta = false
                prod3.descricao = "Descrição do Café"
            
            // Inserindo Pedidos
            
                let ped1 = Dao<Pedido>().new()
                ped1.numero = 101010
                ped1.status = "Em processamento..."
                ped1.valorTotal = 100
                
                let item1 = Dao<Item>().new()
                item1.quantidade = 2
                item1.produto = Dao<Produto>().new()
                item1.produto?.nome = "Café Pelé"
                item1.produto?.preco = 10
                item1.produto?.tipo = "Café"
                item1.produto?.oferta = true
                item1.produto?.precoOferta = 9
                item1.produto?.descricao = "Descrição do Café"
                
                let item2 = Dao<Item>().new()
                item2.quantidade = 3
                item2.produto = Dao<Produto>().new()
                item2.produto?.nome = "Café Pilão"
                item2.produto?.preco = 20
                item2.produto?.tipo = "Café"
                item2.produto?.oferta = false
                item2.produto?.descricao = "Descrição do Café"
                
                ped1.addToItens(item1)
                ped1.addToItens(item2)
                
                let ped2 = Dao<Pedido>().new()
                ped2.numero = 202020
                ped2.status = "Em processamento..."
                ped2.valorTotal = 100
                ped2.itens = NSSet()
                
                let item3 = Dao<Item>().new()
                item3.quantidade = 2
                item3.produto = Dao<Produto>().new()
                item3.produto?.nome = "Café 3 Corações"
                item3.produto?.preco = 20
                item3.produto?.tipo = "Café"
                item3.produto?.oferta = false
                item3.produto?.precoOferta = 9
                item3.produto?.descricao = "Descrição do Café"
                
                let item4 = Dao<Item>().new()
                item4.quantidade = 3
                item4.produto = Dao<Produto>().new()
                item4.produto?.nome = "Café Illy"
                item4.produto?.preco = 50
                item4.produto?.tipo = "Café"
                item4.produto?.oferta = false
                item4.produto?.descricao = "Descrição do Café"
                
                ped2.addToItens(item3)
                ped2.addToItens(item4)
            
            // Inserindo Cafés
            
                var nomes = ["AC CAFÉ", "CARMO ESTATE COFFEE", "DB ESTATE COFFEE", "ECOAGRÍCOLA CAFÉ LTDA",
                             "FAZENDA BELA VISTA", "FAZENDA CAMBARÁ", "FAZENDA CAMOCIM", "FAZENDA CAPOEIRA ESTATE COFFEE", "FAZENDA DO SERTÃO",
                             "FAZENDA DUTRA", "FAZENDA HELENA", "Café Pelé", "3 Corações", "FAZENDA SERRA DAS TRÊS BARRAS",
                             "FAZENDINHA DO VOVÔ", "IPANEMA COFFEES", "KALDI CAFÉ GOURMET PREMIUM - FAZENDA HARMONIA", "O'COFFEE BRAZILIAN ESTATES",
                             "PEREIRA STATE COFFEE", "SANTA ROSA ESTATE COFFEE", "Nespresso" ]
                
                nomes.sort()
            
                let dao = Dao<Cafe>()
            
                for i in 1..<nomes.count {
                    let c = dao.new()
                    c.nome = nomes[i]
                    c.altitude = 20
                    c.cidade = "três lagoas"
                    c.estado = "MS"
                    c.pais = "Brasil"
                    c.descricao = "Um café bom..."
                    c.produtor = "Asdrubal"
                    c.torrador = "Epaminondas"
                    c.regiao = "montanhosa"
                    c.tipo = "Arábico"
                    c.safra = "20/02/2014"
                    
                    let flavor = Dao<Flavor>().new()
                    flavor.amargo = 10
                    flavor.azedo = 1
                    flavor.caramelo = 2
                    flavor.cereais = 3
                    flavor.chocolate = 4
                    flavor.defumado = 5
                    flavor.doce = 6
                    flavor.encorpado = 7
                    flavor.especiarias = 8
                    flavor.floral = 9
                    flavor.frutasCaroco = 10
                    flavor.frutasCitricas = 1
                    flavor.frutasVermelhas = 2
                    flavor.herbal = 3
                    flavor.nozes = 4
                    flavor.salgado = 5
                    
                    c.flavorTorrador = flavor
                    c.latitude = -23.548064
                    c.longitude = -46.5708517
                }
                
                dao.save()

            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
        }
    }
    
}
