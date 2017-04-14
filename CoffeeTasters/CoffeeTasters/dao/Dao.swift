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
            print("* CoreData - abrindo \(banco!) no ctx: \(managedContext!)")
        } else {
            print("**************************")
            print("* CoreData - Não consegui instanciar o contexto do banco de dados")
            print("**************************")
        }
        
    }
    
    func new() -> T {
        print("* CoreData - criando \(banco!) no ctx: \(managedContext!)")
        return NSEntityDescription.insertNewObject(forEntityName: banco!,
                                                   into: managedContext) as! T
    }
    
    func getPorID(_ id: NSManagedObjectID) -> T {
        do {
            return try managedContext.existingObject(with: id) as! T
        } catch let error as NSError {
            print("**************************")
            print("* CoreData - Não consegui buscar por id. \(error), \(error.userInfo)")
            print("**************************")
        }
        return T.self as! T
    }
    
    func list() -> [T] {
        var retorno:[T] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
        
        do {
            retorno = try managedContext.fetch(fetchRequest) as! [T]
            print("* CoreData - Listando \(banco!) [\(retorno.count)]")
        } catch let error as NSError {
            print("**************************")
            print("* CoreData - Could not fetch. \(error), \(error.userInfo)")
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
                print("* CoreData - salvando \(banco!) no ctx: \(managedContext!)")
                try managedContext.save()
            } catch let error as NSError {
                print("**************************")
                print("* CoreData - Impossível salvar... \(error), \(error.userInfo)")
                print("**************************")
            }
        } else {
            print("**************************")
            print("* CoreData - Nada para salvar")
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
            print("* CoreData - Error: \(error.localizedDescription)")
            print("**************************")
            return 0
        }
    }
    
    func inserirDadosIniciais () {
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        if !dadosInseridos {
            
            print("**************************")
            print("* CoreData - inserindo dados iniciais")
            
            // Inserindo Produtos
                print("* CoreData - Inserindo produtos")
                let prodDao = Dao<Produto>()
                let produto1 = prodDao.new()
                produto1.nome = "Café Pelé"
                produto1.preco = 10
                produto1.tipo = "Café"
                produto1.oferta = true
                produto1.precoOferta = 9
                produto1.descricao = "Descrição do Café"
                prodDao.save()
            
            // Inserindo Itens
            
                print("* CoreData - Inserindo Itens")
                let itemDao = Dao<Item>()
                let item1 = itemDao.new()
                item1.quantidade = 2
                item1.produto = produto1
                itemDao.save()
            
            // Inserindo Pedidos
                print("* CoreData - Inserindo Pedido")
                let pedDao = Dao<Pedido>()
                let ped1 = pedDao.new()
                ped1.numero = 101010
                ped1.data = "10/10/2010"
                ped1.status = "Em processamento..."
                ped1.valorTotal += Double(item1.quantidade) * (item1.produto?.preco)!
                ped1.addToItens(item1)
                pedDao.save()
            
            // Inserindo Carrinho
            
//                print("inserindo carrinho")
//                let carrinhoDao = CarrinhoDao()
//                carrinhoDao.getCarrinho()
//                carrinhoDao.save()
            
            // Inserindo Cafés
            
                print("* CoreData - inserindo cafes")
                var nomes = ["AC CAFÉ", "CARMO ESTATE COFFEE", "DB ESTATE COFFEE", "ECOAGRÍCOLA CAFÉ LTDA",
                             "FAZENDA BELA VISTA", "FAZENDA CAMBARÁ", "FAZENDA CAMOCIM", "FAZENDA CAPOEIRA ESTATE COFFEE", "FAZENDA DO SERTÃO",
                             "FAZENDA DUTRA", "FAZENDA HELENA", "Café Pelé", "3 Corações", "FAZENDA SERRA DAS TRÊS BARRAS", "Nespresso" ]
                nomes.sort()
            
                let cafeDao = Dao<Cafe>()
                var c:Cafe!
                var flavor:Flavor!
                for i in 1..<nomes.count {
                    c = cafeDao.new()
                    c.nome = nomes[i]
                    c.altitude = 20
                    //c.imagem = #imageLiteral(resourceName: "cafe")
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
                cafeDao.save()
            
            // Inserindo uma avaliacao
            
                print("* CoreData - inserindo avaliacao")
                let avaliaDao = Dao<Avaliacao>()
                let avaliacao = avaliaDao.new()
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
                avaliaDao.save()
            
            // Inserindo Preparos
            
//            print("* CoreData - inserindo preparos")
//            
//            let imagemDao = Dao<Imagens>()
//            let imagem = imagemDao.new()
//            imagem.nome = #imageLiteral(resourceName: "Coado")
//            imagemDao.save()
//            
//            let passoDao = Dao<Passo>()
//        
//            let passo1 = passoDao.new()
//            passo1.indice = 1
//            passo1.tempo = 0
//            passo1.addToImagens(NSSet(array:[imagem]))
//            passo1.descricao = "Moer os grãos"
//        
//            let passo2 = passoDao.new()
//            passo2.indice = 2
//            passo2.tempo = 0
//            passo2.addToImagens(NSSet(array:[imagem]))
//            passo2.descricao = "Colocar o pó no coador"
//            
//            let passo3 = passoDao.new()
//            passo3.indice = 3
//            passo3.tempo = 0
//            passo3.addToImagens(NSSet(array:[imagem]))
//            passo3.descricao = "Jogar agua e esperar"
//            
//            let passo4 = passoDao.new()
//            passo4.indice = 4
//            passo4.tempo = 3
//            passo4.addToImagens(NSSet(array:[imagem]))
//            passo4.descricao = "Colocar na garrafa térmica"
//            
//            let passo5 = passoDao.new()
//            passo5.indice = 1
//            passo5.tempo = 0
//            passo5.addToImagens(NSSet(array:[imagem]))
//            passo5.descricao = "Moer os grãos"
//            
//            let passo6 = passoDao.new()
//            passo6.indice = 2
//            passo6.tempo = 0
//            passo6.addToImagens(NSSet(array:[imagem]))
//            passo6.descricao = "Colocar o pó no coador"
//            
//            let passo7 = passoDao.new()
//            passo7.indice = 3
//            passo7.tempo = 0
//            passo7.addToImagens(NSSet(array:[imagem]))
//            passo7.descricao = "Jogar agua e esperar"
//            
//            let passo8 = passoDao.new()
//            passo8.indice = 4
//            passo8.tempo = 2
//            passo8.addToImagens(NSSet(array:[imagem]))
//            passo8.descricao = "Colocar na garrafa térmica"
//            
//            passoDao.save()
//            
//            let preparoDao = Dao<Preparo>()
//            
//            /// Inicio do preparo1
//            let preparo1 = preparoDao.new()
//            preparo1.nome = "Coado"
//            preparo1.imagem = imagem
//            
//            preparo1.addToPasso(passo1)
//            preparo1.addToPasso(passo2)
//            preparo1.addToPasso(passo3)
//            preparo1.addToPasso(passo4)
//            
//            /// Inicio do preparo2
//            let preparo2 = preparoDao.new()
//            preparo2.nome = "Prensa Francesa"
//            preparo2.imagem = imagem
//            
//            preparo2.addToPasso(passo5)
//            preparo2.addToPasso(passo6)
//            preparo2.addToPasso(passo7)
//            preparo2.addToPasso(passo8)
//            
//            preparoDao.save()
            
                print("**************************")

            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
        }
    }
    
}
