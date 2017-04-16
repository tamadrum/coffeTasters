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
            print("* CoreData - pegando por ID: \(id.description) do \(banco!) no ctx: \(managedContext!)")
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
        print("* CoreData - deletando obj do \(banco!) no ctx: \(managedContext!)")
        managedContext.delete(obj)
    }
    
    func reset () {
        print("* CoreData - resetando o contexto: \(managedContext!)")
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
            
            print("* CoreData - contagem do \(banco!) no ctx: \(managedContext!) é de \(count)")
            
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
                let itemDao = Dao<Item>()
                let item1 = itemDao.new()
                item1.quantidade = 2
                item1.produto = produto1
                itemDao.save()
            
            // Inserindo Pedidos
                let pedDao = Dao<Pedido>()
                let ped1 = pedDao.new()
                ped1.numero = 101010
                ped1.data = "10/10/2010"
                ped1.status = "Em processamento..."
                ped1.valorTotal += Double(item1.quantidade) * (item1.produto?.preco)!
                ped1.addToItens(item1)
                pedDao.save()
            
            // Inserindo Carrinho
                let carrinhoDao = CarrinhoDao()
                let carrinho = carrinhoDao.getCarrinho()
                carrinhoDao.save()
                print("Carrinho criado com R$ \(carrinho.valorTotal)")
            
            // Inserindo Cafés
                var nomes = ["AC CAFÉ", "CARMO ESTATE COFFEE", "DB ESTATE COFFEE", "ECOAGRÍCOLA CAFÉ LTDA",
                             "FAZENDA BELA VISTA", "FAZENDA CAMBARÁ", "FAZENDA CAMOCIM", "FAZENDA CAPOEIRA ESTATE COFFEE", "FAZENDA DO SERTÃO",
                             "FAZENDA DUTRA", "FAZENDA HELENA", "Café Pelé", "3 Corações", "FAZENDA SERRA DAS TRÊS BARRAS", "Nespresso" ]
                nomes.sort()
            
                let cafeDao = Dao<Cafe>()
                let flavorDao = Dao<Flavor>()
            
                var c:Cafe!
                var flavor:Flavor!
                for i in 0..<nomes.count {
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
                    
                    flavor = flavorDao.new()
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
            
            // Inserindo Preparos
            
            let preparoDao = Dao<Preparo>()
            let passoDao = Dao<Passo>()
        
            let passo1 = passoDao.new()
            passo1.indice = 1
            passo1.tempo = 0
            passo1.imagem = #imageLiteral(resourceName: "cafe")
            passo1.descricao = "Moer os grãos"
        
            let passo2 = passoDao.new()
            passo2.indice = 2
            passo2.tempo = 0
            passo2.imagem = #imageLiteral(resourceName: "cafe")
            passo2.descricao = "Colocar o pó no coador"
            
            let passo3 = passoDao.new()
            passo3.indice = 3
            passo3.tempo = 0
            passo3.imagem = #imageLiteral(resourceName: "cafe")
            passo3.descricao = "Jogar agua e esperar"
            
            let passo4 = passoDao.new()
            passo4.indice = 4
            passo4.tempo = 3
            passo4.imagem = #imageLiteral(resourceName: "cafe")
            passo4.descricao = "Colocar na garrafa térmica"
            
            let passo5 = passoDao.new()
            passo5.indice = 1
            passo5.tempo = 0
            passo5.imagem = #imageLiteral(resourceName: "cafe")
            passo5.descricao = "Moer os grãos"
            
            let passo6 = passoDao.new()
            passo6.indice = 2
            passo6.tempo = 0
            passo6.imagem = #imageLiteral(resourceName: "cafe")
            passo6.descricao = "Colocar o pó no coador"
            
            let passo7 = passoDao.new()
            passo7.indice = 3
            passo7.tempo = 0
            passo7.imagem = #imageLiteral(resourceName: "cafe")
            passo7.descricao = "Jogar agua e esperar"
            
            let passo8 = passoDao.new()
            passo8.indice = 4
            passo8.tempo = 2
            passo8.imagem = #imageLiteral(resourceName: "cafe")
            passo8.descricao = "Colocar na garrafa térmica"
            
            /// Inicio do preparo
            let preparo1 = preparoDao.new()
            preparo1.nome = "Prensa Francesa"
            preparo1.imagem = #imageLiteral(resourceName: "Prensa-1")
            
            preparo1.addToPasso(passo5)
            preparo1.addToPasso(passo6)
            preparo1.addToPasso(passo7)
            preparo1.addToPasso(passo8)
            
            /// Inicio do preparo
            let preparo2 = preparoDao.new()
            preparo2.nome = "Espresso"
            preparo2.imagem = #imageLiteral(resourceName: "Espresso_1")
            
            preparo2.addToPasso(passo1)
            preparo2.addToPasso(passo2)
            preparo2.addToPasso(passo3)
            preparo2.addToPasso(passo4)
            
            /// Inicio do preparo
            let preparo3 = preparoDao.new()
            preparo3.nome = "Coado"
            preparo3.imagem = #imageLiteral(resourceName: "Coado-1")
            
            /// Inicio do preparo
            let preparo4 = preparoDao.new()
            preparo4.nome = "Moca"
            preparo4.imagem = #imageLiteral(resourceName: "Moca-1")
            
            /// Inicio do preparo
            let preparo5 = preparoDao.new()
            preparo5.nome = "Aeropress"
            preparo5.imagem = #imageLiteral(resourceName: "Aeropress-1")
            
            /// Inicio do preparo
            let preparo6 = preparoDao.new()
            preparo6.nome = "Clever"
            preparo6.imagem = #imageLiteral(resourceName: "Clever-1")
            
            preparoDao.save()
            
                print("**************************")

            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
        }
    }
    
}
