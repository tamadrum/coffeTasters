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
    
    func listDistinct() -> [T] {
        var retorno:[T] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: banco!)
        fetchRequest.returnsDistinctResults = true
        
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

            let cafeDao = Dao<Cafe>()
            let flavorDao = Dao<Flavor>()
            
            let flavor = flavorDao.new()
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
            
            let cafe1 = cafeDao.new()
            cafe1.nome = "Catuaí Vermelho Sítio Alto Ouro"
            cafe1.pais = "Brasil"
            cafe1.cidade = "Guarapari"
            cafe1.estado = "es"
            cafe1.produtor = "Dorvanil D'Agostine da Silva"
            cafe1.tipo = "arabica catuai vermelho"
            cafe1.torrador = "Raposeiras"
            cafe1.regiao = "Vargem Alta"
            cafe1.latitude = -20.547778
            cafe1.longitude = -41.010833
            cafe1.altitude = 1200
            //cafe1.processo = "descascado"
            cafe1.ehBlend = false
            cafe1.safra = "2016/17"
            cafe1.metodo = false // coffeLab
            cafe1.flavorTorrador = flavor
            
            let cafe2 = cafeDao.new()
            cafe2.nome = "Bourbon Amarelo (Carmo 13) - Fazenda Santa Inês"
            cafe2.pais = "Brasil"
            cafe2.cidade = "."
            cafe2.estado = "mg"
            cafe2.produtor = "Francisco Pereira"
            cafe2.tipo = "arabica boubon amarelo"
            cafe2.torrador = "Raposeiras"
            cafe2.regiao = "carmo de minas"
            cafe2.latitude = -22.091389
            cafe2.longitude = -45.169056
            cafe2.altitude = 950
            //cafe2.processo = natural
            cafe2.ehBlend = false
            cafe2.safra = "2016/17"
            cafe2.metodo = false // coffeLab
            cafe2.flavorTorrador = flavor
            
            let cafe3 = cafeDao.new()
            cafe3.nome = "785 - Sítio Rancho Dantas"
            cafe3.pais = "Brasil"
            cafe3.cidade = "."
            cafe3.estado = "es"
            cafe3.produtor = "Joselino Meneguete"
            cafe3.tipo = "arabica"
            cafe3.torrador = "Raposeiras"
            cafe3.regiao = "Brejetuba"
            cafe3.latitude = -20.909444
            cafe3.longitude = -41.040833
            cafe3.altitude = 950
            //cafe1.processo = "descascado"
            cafe3.ehBlend = false
            cafe3.safra = "2016/17"
            cafe3.metodo = false // coffeLab
            cafe3.flavorTorrador = flavor
            
            let cafe4 = cafeDao.new()
            cafe4.nome = "FAF-Cartola-Micro lote"
            cafe4.pais = "Brasil"
            cafe4.cidade = "."
            cafe4.estado = "sp"
            cafe4.produtor = "Fazenda Ambiental Fortaleza"
            cafe4.tipo = "arabica"
            cafe4.torrador = "Isso e Caffe"
            cafe4.regiao = "mococa"
            cafe4.latitude = 0
            cafe4.longitude = 0
            cafe4.altitude = 645
            //cafe4.processo =
            cafe4.ehBlend = false
            //cafe4.safra
            cafe4.metodo = false // Mirante 9 de Julho
            cafe4.flavorTorrador = flavor
            
            let cafe5 = cafeDao.new()
            cafe5.nome = "FAF-Icatu-Micro lote"
            cafe5.pais = "Brasil"
            cafe5.cidade = "."
            cafe5.estado = "sp"
            cafe5.produtor = "Fazenda Ambiental Fortaleza"
            cafe5.tipo = "arabica"
            cafe5.torrador = "Isso e Caffe"
            cafe5.regiao = "mococa"
            //cafe5.latitude
            //cafe5.longitude
            cafe5.altitude = 646
            //cafe5.processo
            cafe5.ehBlend = false
            //cafe5.safra =
            cafe5.metodo = false // Mirante 9 de Julho
            cafe5.flavorTorrador = flavor
            
            let cafe6 = cafeDao.new()
            cafe6.nome = "FAF-Cobatã-Micro lote"
            cafe6.pais = "Brasil"
            cafe6.cidade = "."
            cafe6.estado = "sp"
            cafe6.produtor = "Fazenda Ambiental Fortaleza"
            cafe6.tipo = "arabica"
            cafe6.torrador = "Isso e Caffe"
            cafe6.regiao = "mococa"
            //cafe6.latitude
            //cafe6.longitude
            cafe6.altitude = 647
            //cafe6.processo
            cafe6.ehBlend = false
            //cafe6.safra
            cafe6.metodo = false // Mirante 9 de Julho
            cafe6.flavorTorrador = flavor
            
            let cafe7 = cafeDao.new()
            cafe7.nome = "Orfeu Blend Suave"
            cafe7.pais = "brasil"
            cafe7.cidade = "."
            cafe7.estado = "sp"
            cafe7.produtor = "FAZENDA RAINHA"
            cafe7.tipo = "arabica Boubon amarelo"
            cafe7.torrador = "Orfeu"
            cafe7.regiao = "São Sebastião da Grama"
            //cafe7.latitude
            //cafe7.longitude
            cafe7.altitude = 1400
            //cafe7.processo = "descascado"
            cafe7.ehBlend = false
            //cafe7.safra
            cafe7.metodo = false //
            cafe7.flavorTorrador = flavor
            
            let cafe8 = cafeDao.new()
            cafe8.nome = "CAFÉ SANTA RITA - SALADA DE FRUTAS"
            cafe8.pais = "Brasil"
            cafe8.cidade = "."
            cafe8.estado = "mg"
            cafe8.produtor = "arabica Catuaí Vermelho"
            //cafe8.tipo
            cafe8.torrador = "Espera Feliz"
            //cafe8.regiao
            //cafe8.latitude
            //cafe8.longitude
            cafe8.altitude = 1050
            //cafe8.processo = natural
            cafe8.ehBlend = false
            cafe8.safra = "2016/17"
            cafe8.metodo = false
            cafe8.flavorTorrador = flavor
            
            let cafe9 = cafeDao.new()
            cafe9.nome = "Ninho da Águia"
            cafe9.pais = "Brasil"
            cafe9.cidade = "."
            cafe9.estado = "mg"
            cafe9.produtor = "Clayton Barossa Monteiro"
            cafe9.tipo = "arabica catuai vermelho"
            cafe9.torrador = "ninho da Aguia"
            cafe9.regiao = "Serra do Caparaó"
            //cafe9.latitude
            //cafe9.longitude
            cafe9.altitude = 1250
            //cafe9.processo = "natural"
            cafe9.ehBlend = false
            cafe9.safra = "2016/17"
            cafe9.metodo = false
            cafe9.flavorTorrador = flavor
            
            cafeDao.save()
            
            // Inserindo Preparos
            
            let preparoDao = Dao<Preparo>()
            let passoDao = Dao<Passo>()
            
            let materiaisPrensaFrancesa = #imageLiteral(resourceName: "ingredientesPrensaFrancesa")
            let prensaFrancesa = ["Pese 6g de café para cada 100mL de bebida",
            "moa o café (moagem grossa)",
            "Aqueça a água até que comece a ferver",
            "Escalde o frasco",
            "Coloque, nesta ordem, o café moído e a água quente",
            "Mexa, coloque a tampa e deixe em infusão por 3-5 minutos",
            "abaixe o êmbolo lentamente para não revolver o pó"]
            let temposPrensaFrancesa = [0, 0, 0, 0, 0, 300, 0]

            let materiaisEspresso = #imageLiteral(resourceName: "ingredientesEspresso")
            let espresso = ["Pese de 5-7g de café por dose de bebida",
            "Moa o café (moagem fina)",
            "Coloque o café moído no porta-filtro",
            "prense o pó no porta-filtro de modo uniforme utilizando o tamper",
            "prenda corretamente o porta-filtro na máquina",
            "Escalde a xícara",
            "Inicie a extração, contando o tempo após a primeira gota",
            "Extraia por 25 segundos (30 mL de bebida)"]
            let temposEspresso = [0, 0, 0, 0, 0, 0, 0, 25]
            
            let materiaisCoadoCleverChemex = #imageLiteral(resourceName: "ingredientesClever")
            let coadoCleverChemex = ["Pese 15g de café para cada 200mL de bebida",
                "Moa o café (moagem fina)",
                "Aqueça a água até que comece a ferver",
                "Escalde o frasco e o papel de filtro",
                "coloque o pó no filtro",
                "umedeça o pó com um pouco de água e espere 30 segundos",
                "Se for preparar por clever, derrame o restante da água e deixe em infusão por 3-5 minutos",
                "libere a válvula do clever e espere coar todo líquido",
                "Se for preparar por coado/chemex, derrame o restante da água em movimentos circulares",
                "espere coar todo líquido"]
            let temposCoadoCleverChemex = [0, 0, 0, 0, 0, 30, 300, 0, 0, 0]

            let materiaisAeropress = #imageLiteral(resourceName: "ingredientesAeropress")
            let aeropress = ["Pese 18g de café para cada 200mL de bebida",
                "Moa o café (moagem média)",
                "Aqueça a água até que comece a ferver",
                "Escalde o frasco e o filtro",
                "Coloque, nesta ordem, o café moído e a água quente",
                "Mexa e deixe em infusão por 1 minuto",
                "Coloque a tampa e abaixe o êmbolo lentamente"]
            let temposAeropress = [0, 0, 0, 0, 0, 60, 0]
            
            let materiaisMoka = #imageLiteral(resourceName: "ingredientesMoka")
            let moka = ["moa café suficiente para encher o porta-pó (moagem média)",
            "Coloque água filtrada na base da moka o suficiente para encher até a base da válvula de segurança",
            "Coloque o suficiente de café moído para encher o porta-pó, sem compactá-lo",
            "Feche corretamente o conjunto da moka",
            "Aqueça em fogo baixo com a tampa levantada.",
            "apague o fogo e abaixar a tampa quando o café começar a verter na parte de cima",
            "sirva quando cessar de verter café pela parte de cima."]
            let temposMoka = [0, 0, 0, 0, 0, 0, 0]

            let passosPrensaFrancesa = preparaPassos(passoDao, passos: prensaFrancesa, imagem: materiaisPrensaFrancesa, tempos:temposPrensaFrancesa)
            preparaPreparo(preparoDao, passos: passosPrensaFrancesa, imagem: #imageLiteral(resourceName: "Prensa-1"), nome: "Prensa Francesa")
            
            let passosEspresso = preparaPassos(passoDao, passos: espresso, imagem: materiaisEspresso, tempos: temposEspresso)
            preparaPreparo(preparoDao, passos: passosEspresso, imagem: #imageLiteral(resourceName: "Espresso_1"), nome: "Espresso")
            
            let passosCoadoCleverChemex = preparaPassos(passoDao, passos: coadoCleverChemex, imagem: materiaisCoadoCleverChemex, tempos:temposCoadoCleverChemex)
            preparaPreparo(preparoDao, passos: passosCoadoCleverChemex, imagem: #imageLiteral(resourceName: "Coado-1"), nome: "Coado/Clever/Chenex")
            
            let passosMoka = preparaPassos(passoDao, passos: moka, imagem: materiaisMoka, tempos:temposMoka)
            preparaPreparo(preparoDao, passos: passosMoka, imagem: #imageLiteral(resourceName: "Moca-1"), nome: "Moka")
            
            let passosAeropress = preparaPassos(passoDao, passos: aeropress, imagem: materiaisAeropress , tempos:temposAeropress)
            preparaPreparo(preparoDao, passos: passosAeropress, imagem: #imageLiteral(resourceName: "Aeropress-1"), nome: "Aeropress")
            
                print("**************************")

            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
        }
    }
    
    func preparaPassos(_ dao: Dao<Passo>, passos:[String], imagem: UIImage, tempos:[Int]) -> [Passo] {
        var retorno:[Passo] = []
        
        for i in 0..<passos.count {
            let passo = dao.new()
            passo.indice = i+1
            passo.tempo = Int32(tempos[i])
            passo.imagem = imagem
            passo.descricao = passos[i]
        
            retorno.append(passo)
        }
        
        return retorno
    }
    
    func preparaPreparo(_ dao: Dao<Preparo>, passos:[Passo], imagem: UIImage, nome: String) {
        let preparo = dao.new()
        preparo.nome = nome
        preparo.imagem = imagem
        
        for passo in passos {
            preparo.addToPasso(passo)
        }
        
        dao.save()
    }
    
}
