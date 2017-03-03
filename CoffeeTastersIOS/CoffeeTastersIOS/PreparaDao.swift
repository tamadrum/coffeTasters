//
//  PreparaDao.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 03/03/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class PreparaDao {

    func getPreparo() -> Preparo {
    
        var passos = Array<Passo>()
        
        let passo1 = Passo(indice: 1, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Moer os grãos")
        let passo2 = Passo(indice: 2, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Colocar o pó no coador")
        let passo3 = Passo(indice: 3, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Jogar agua e esperar")
        let passo4 = Passo(indice: 4, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Colocar na garrafa térmica")
        
        passos.append(passo1)
        passos.append(passo2)
        passos.append(passo3)
        passos.append(passo4)
        
        let coado = Preparo(passos: passos)
        
        return coado
        

    
    }

}
