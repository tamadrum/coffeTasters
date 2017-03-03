//
//  PreparaDao.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 03/03/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class PreparaDao {

    func getPreparo() -> Array<Preparo> {
    
        var passosCoado = Array<Passo>()
        
        let passoCoado1 = Passo(indice: 1, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Moer os grãos")
        let passoCoado2 = Passo(indice: 2, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Colocar o pó no coador")
        let passoCoado3 = Passo(indice: 3, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Jogar agua e esperar")
        let passoCoado4 = Passo(indice: 4, tipo: "Coado", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Colocar na garrafa térmica")
        
        passosCoado.append(passoCoado1)
        passosCoado.append(passoCoado2)
        passosCoado.append(passoCoado3)
        passosCoado.append(passoCoado4)
        
        let coado = Preparo(passos: passosCoado)
    
        var passosPrensa = Array<Passo>()
        
        let passoPrensa1 = Passo(indice: 1, tipo: "Prensa", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Moer os grãos para a prensa")
        let passoPrensa2 = Passo(indice: 2, tipo: "Prensa", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Colocar o pó no coador para a prensa")
        let passoPrensa3 = Passo(indice: 3, tipo: "Prensa", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Jogar agua e esperar para a prensa")
        let passoPrensa4 = Passo(indice: 4, tipo: "Prensa", tempo: 5, imagens: ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"], descricao: "Colocar na garrafa térmica para a prensa")
        
        passosPrensa.append(passoPrensa1)
        passosPrensa.append(passoPrensa2)
        passosPrensa.append(passoPrensa3)
        passosPrensa.append(passoPrensa4)
        
        let prensa = Preparo(passos: passosPrensa)
        
        var preparos:Array<Preparo> = []
        preparos.append(coado)
        preparos.append(prensa)
        
        
        return preparos
        

    
    }

}
