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
            
            let materiaisPrensaFrancesa = ["café em grão",
                "Balança",
                "Água filtrada",
                "moedor",
                "chaleira",
                "prensa francesa",
                "colher"]
            let prensaFrancesa = ["Pese 6g de café para cada 100mL de bebida",
            "moa o café (moagem grossa)",
            "Aqueça a água até que comece a ferver",
            "Escalde o frasco",
            "Coloque, nesta ordem, o café moído e a água quente",
            "Mexa, coloque a tampa e deixe em infusão por 3-5 minutos",
            "abaixe o êmbolo lentamente para não revolver o pó"]

            let materiaisEspresso = ["café em grão",
                "Moedor",
                "Água filtrada",
                "máquina de expresso",
                "porta filtro",
                "tamper",
                "balança digital",
                "xícaras aquecidas"]
            let espresso = ["Pese de 5-7g de café por dose de bebida",
            "Moa o café (moagem fina)",
            "Coloque o café moído no porta-filtro",
            "prense o pó no porta-filtro de modo uniforme utilizando o tamper",
            "prenda corretamente o porta-filtro na máquina",
            "Escalde a xícara",
            "Inicie a extração, contando o tempo após a primeira gota",
            "Extraia por 25 segundos (30 mL de bebida)"]
            
            let materiaisCoadoCleverChemex = ["café em grão",
                "Balança",
                "Água filtrada",
                "moedor",
                "chaleira",
                "porta filtro",
                "filtro de papel",
                "jarra para preparo"]
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

            let materiaisAeropress = ["café em grão",
                "balança",
                "Moedor",
                "água filtrada",
                "chaleira",
                "aeropress",
                "filtro aeropress",
                "colher",
                "funil"]
            let aeropress = ["Pese 18g de café para cada 200mL de bebida",
                "Moa o café (moagem média)",
                "Aqueça a água até que comece a ferver",
                "Escalde o frasco e o filtro",
                "Coloque, nesta ordem, o café moído e a água quente",
                "Mexa e deixe em infusão por 1 minuto",
                "Coloque a tampa e abaixe o êmbolo lentamente"]
            
            let materiaisMoka = ["café em grão",
                "balança",
                "moedor",
                "Agua filtrada",
                "fogão"]
            let moka = ["moa café suficiente para encher o porta-pó (moagem média)",
            "Coloque água filtrada na base da moka o suficiente para encher até a base da válvula de segurança",
            "Coloque o suficiente de café moído para encher o porta-pó, sem compactá-lo",
            "Feche corretamente o conjunto da moka",
            "Aqueça em fogo baixo com a tampa levantada.",
            "apague o fogo e abaixar a tampa quando o café começar a verter na parte de cima",
            "sirva quando cessar de verter café pela parte de cima."]

            let passosPrensaFrancesa = preparaPassos(passoDao, passos: prensaFrancesa)
            preparaPreparo(preparoDao, passos: passosPrensaFrancesa, imagem: #imageLiteral(resourceName: "Prensa-1"), nome: "Prensa Francesa")
            
            let passosEspresso = preparaPassos(passoDao, passos: espresso)
            preparaPreparo(preparoDao, passos: passosEspresso, imagem: #imageLiteral(resourceName: "Espresso_1"), nome: "Espresso")
            
            let passosCoadoCleverChemex = preparaPassos(passoDao, passos: coadoCleverChemex)
            preparaPreparo(preparoDao, passos: passosCoadoCleverChemex, imagem: #imageLiteral(resourceName: "Coado-1"), nome: "Coado/Clever/Chenex")
            
            let passosMoka = preparaPassos(passoDao, passos: moka)
            preparaPreparo(preparoDao, passos: passosMoka, imagem: #imageLiteral(resourceName: "Moca-1"), nome: "Moka")
            
            let passosAeropress = preparaPassos(passoDao, passos: aeropress)
            preparaPreparo(preparoDao, passos: passosAeropress, imagem: #imageLiteral(resourceName: "Aeropress-1"), nome: "Aeropress")
            
                print("**************************")

            configuracoes.set(true, forKey: "dados_inseridos")
            configuracoes.synchronize()
        }
    }
    
    func preparaPassos(_ dao: Dao<Passo>, passos:[String]) -> [Passo] {
        var retorno:[Passo] = []
        
        for i in 0..<passos.count {
            let passo = dao.new()
            passo.indice = i+1
            passo.tempo = 0
            passo.imagem = #imageLiteral(resourceName: "cafe")
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
