//
//  AvaliacoesDao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class AvaliacoesDao {
    func getAvaliacoes() -> Array<Avaliacao> {
        var avaliacoes = Array<Avaliacao>()
        
        let a = Avaliacao()
        
        let calendario = Calendar.current
        let data = DateComponents(year: 2030, month: 10, day: 20)
        
        a.obs = "Eu gostei muito do café"
        a.data = calendario.date(from: data)!
        a.gostou = 2
        a.metodoPreparo = "Solúvel"
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
        cafe.flavor.amargo = 4
        cafe.flavor.azedo = 1
        cafe.flavor.caramelo = 8
        cafe.flavor.cereais = 9
        cafe.flavor.chocolate = 2
        cafe.flavor.defumado = 3
        cafe.flavor.doce = 3
        cafe.flavor.encorpado = 5
        cafe.flavor.especiarias = 5
        cafe.flavor.floral = 6
        cafe.flavor.frutasCaroco = 5
        cafe.flavor.frutasCitrico = 9
        cafe.flavor.frutasVermelhas = 10
        cafe.flavor.herbal = 1
        cafe.flavor.nozes = 1
        cafe.flavor.salgado = 5
        
        a.cafe = cafe
        
        a.flavor = Flavor()
        a.flavor.amargo = 5
        a.flavor.azedo = 5
        a.flavor.caramelo = 5
        a.flavor.cereais = 5
        a.flavor.chocolate = 5
        a.flavor.defumado = 5
        a.flavor.doce = 5
        a.flavor.encorpado = 5
        a.flavor.especiarias = 5
        a.flavor.floral = 5
        a.flavor.frutasCaroco = 5
        a.flavor.frutasCitrico = 5
        a.flavor.frutasVermelhas = 5
        a.flavor.herbal = 5
        a.flavor.nozes = 5
        a.flavor.salgado = 5
        
        avaliacoes.append(a)
        
        return avaliacoes
    }
}
