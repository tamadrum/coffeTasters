//
//  CafeDao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class CafeDao: Dao<Cafe> {
    
    func listar() -> [Cafe] {
        var nomes = ["AC CAFÉ", "CARMO ESTATE COFFEE", "DB ESTATE COFFEE", "ECOAGRÍCOLA CAFÉ LTDA",
                     "FAZENDA BELA VISTA", "FAZENDA CAMBARÁ", "FAZENDA CAMOCIM", "FAZENDA CAPOEIRA ESTATE COFFEE", "FAZENDA DO SERTÃO",
                     "FAZENDA DUTRA", "FAZENDA HELENA", "Café Pelé", "3 Corações", "FAZENDA SERRA DAS TRÊS BARRAS",
                     "FAZENDINHA DO VOVÔ", "IPANEMA COFFEES", "KALDI CAFÉ GOURMET PREMIUM - FAZENDA HARMONIA", "O'COFFEE BRAZILIAN ESTATES",
                     "PEREIRA STATE COFFEE", "SANTA ROSA ESTATE COFFEE", "Nespresso" ]
        var cafes:[Cafe] = []
        
        nomes.sort()
        
        for i in 1..<nomes.count {
            let c = new()
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
            cafes.append(c)
        }
        
        return cafes
    }

    
}
