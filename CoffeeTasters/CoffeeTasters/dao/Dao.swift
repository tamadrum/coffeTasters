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
        } else {
            print("**************************")
            print("Não consegui instanciar o contexto do banco de dados")
            print("**************************")
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
//            print("**************************")
//            print("Listando \(banco!) [\(retorno.count)]")
//            print("**************************")
        } catch let error as NSError {
            print("**************************")
            print("Could not fetch. \(error), \(error.userInfo)")
            print("**************************")
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
//                print("**************************")
//                print("Vou salvar no \(banco!)")
//                print("**************************")
                try managedContext.save()
            } catch let error as NSError {
                print("**************************")
                print("Impossível salvar... \(error), \(error.userInfo)")
                print("**************************")
            }
        } else {
            print("**************************")
            print("Nada para salvar")
            print("**************************")
        }
    }

    func count() -> Int {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
            
            let count = try managedContext.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            print("**************************")
            print("Error: \(error.localizedDescription)")
            print("**************************")
            return 0
        }
    }
    
    func inserirDadosIniciais () {
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        if !dadosInseridos {
            
            print("**************************")
            print("inserindo dados iniciais")
            print("**************************")
            
            // Inserindo Pedidos
            
                let ped1 = Dao<Pedido>().new()
                ped1.numero = 101010
                ped1.data = "10/10/2010"
                ped1.status = "Em processamento..."
                
                let item1 = Dao<Item>().new()
                item1.quantidade = 2
                item1.produto = Dao<Produto>().new()
                item1.produto?.nome = "Café Pelé"
                item1.produto?.preco = 10
                item1.produto?.tipo = "Café"
                item1.produto?.oferta = true
                item1.produto?.precoOferta = 9
                item1.produto?.descricao = "Descrição do Café"
            
                ped1.valorTotal += Double(item1.quantidade) * (item1.produto?.preco)!
                
                let item2 = Dao<Item>().new()
                item2.quantidade = 3
                item2.produto = Dao<Produto>().new()
                item2.produto?.nome = "Café Pilão"
                item2.produto?.preco = 20
                item2.produto?.tipo = "Café"
                item2.produto?.oferta = false
                item2.produto?.descricao = "Descrição do Café"
            
                ped1.valorTotal += Double(item2.quantidade) * (item2.produto?.preco)!
                
                ped1.addToItens(item1)
                ped1.addToItens(item2)
            
            // Inserindo Carrinho
            
                let carrinho = CarrinhoDao().getCarrinho()
                carrinho.addToItens(item1)
                carrinho.addToItens(item2)
            
            // Inserindo Cafés
            
                var nomes = ["AC CAFÉ", "CARMO ESTATE COFFEE", "DB ESTATE COFFEE", "ECOAGRÍCOLA CAFÉ LTDA",
                             "FAZENDA BELA VISTA", "FAZENDA CAMBARÁ", "FAZENDA CAMOCIM", "FAZENDA CAPOEIRA ESTATE COFFEE", "FAZENDA DO SERTÃO",
                             "FAZENDA DUTRA", "FAZENDA HELENA", "Café Pelé", "3 Corações", "FAZENDA SERRA DAS TRÊS BARRAS", "Nespresso" ]
                
                nomes.sort()
                var c:Cafe!
                var flavor:Flavor!
                for i in 1..<nomes.count {
                    c = Dao<Cafe>().new()
                    c.nome = nomes[i]
                    c.altitude = 20
                    c.imagem = #imageLiteral(resourceName: "cafe")
                    c.cidade = "três lagoas"
                    c.estado = "MS"
                    c.pais = "Brasil"
                    c.descricao = "Um café bom..."
                    c.produtor = "Asdrubal"
                    c.torrador = "Epaminondas"
                    c.regiao = "montanhosa"
                    c.tipo = "Arábico"
                    c.safra = "20/02/2014"
                    
                    flavor = Dao<Flavor>().new()
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
            
            // Inserindo uma avaliacao
            
                let avaliacao = Dao<Avaliacao>().new()
                avaliacao.cafe = c
                avaliacao.barista = "Jacksson"
                avaliacao.data = "10/10/2017"
                avaliacao.dataColheita = "10/10/2017"
                avaliacao.dataTorra = "10/10/2017"
                avaliacao.flavor = flavor
                avaliacao.gostou = Int32(3)
                avaliacao.localPreparo = "Marco Polo"
                avaliacao.metodoPreparo = "Prensa"
                avaliacao.obs = "Gostei muito do café e do lugar"
                
            // Salvando tudo o que foi feito
                
                save()

            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
        }
    }
    
}
