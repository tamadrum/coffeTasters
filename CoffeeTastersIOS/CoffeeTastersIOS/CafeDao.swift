//
//  CafeDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class CafeDao {
    
    var data = ["Café Camacho", "Puro Sabor", "Café União", "Café 262", "Bedê", "Piloão de Minas",
                "Uno", "Bom Despacho", "Café Jardim", "Caboclo", "Café Maratá", "Café Brasileiro", "Qualitá", "Café Bom Jesus", "Seleto", "3 Corações", "Café Fort",
                "Café do Ponto", "Café Pimpinela", "Café Pelé", "Melitta", "Pilão"]
    
    func getListaCafe( ) -> Array<Cafe> {
        var retorno: Array<Cafe> = Array<Cafe>()
        
        let calendario = Calendar.current
        
        let dataDaColheita = DateComponents(year: 2020, month: 4, day: 10)
        let dataDaTorra = DateComponents(year: 2030, month: 10, day: 20)
        
        let cafe = Cafe()
        cafe.dataColheita = calendario.date(from: dataDaColheita)!
        cafe.dataTorra = calendario.date(from: dataDaTorra)!
        cafe.nome = "Café Pelé"
        cafe.origem = "Afeganistão"
        cafe.produtor = "Asdrubal"
        cafe.torrador = "Epaminondas"
        cafe.descricao = "dfjks JKS SLKJg fzsjgdf lJKSGHDc zsbdjhvg zskjdf ljBSDfj gas,db jg"
        cafe.imagem = "cafe.jpg"
        cafe.flavor = Flavor()
        cafe.flavor.amargo = 5
        cafe.flavor.azedo = 5
        cafe.flavor.caramelo = 5
        cafe.flavor.cereais = 5
        cafe.flavor.chocolate = 5
        cafe.flavor.defumado = 5
        cafe.flavor.doce = 5
        cafe.flavor.encorpado = 5
        cafe.flavor.especiarias = 5
        cafe.flavor.floral = 5
        cafe.flavor.frutasCaroco = 5
        cafe.flavor.frutasCitrico = 5
        cafe.flavor.frutasVermelhas = 5
        cafe.flavor.herbal = 5
        cafe.flavor.nozes = 5
        cafe.flavor.salgado = 5
        
        retorno.append(cafe)
        
        return retorno
    }
    
}
