//
//  PreparaDao.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 03/03/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class PreparaDao {
    
    func getPreparo() -> [Preparo] {
            let passos = NSSet()
            
            let passo1 = Passo()
            passo1.indice = 1
            passo1.tempo = 5
            passo1.imagens = ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]
            passo1.descricao = "Moer os grãos"

            let passo2 = Passo()
            passo2.indice = 2
            passo2.tempo = 5
            passo2.imagens = ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]
            passo2.descricao = "Colocar o pó no coador"
            
            let passo3 = Passo()
            passo3.indice = 3
            passo3.tempo = 5
            passo3.imagens = ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]
            passo3.descricao = "Jogar agua e esperar"
            
            let passo4 = Passo()
            passo4.indice = 4
            passo4.tempo = 5
            passo4.imagens = ["preparo-1", "preparo-2", "preparo-3", "preparo-4", "preparo-5"]
            passo4.descricao = "Colocar na garrafa térmica"
            
            passos.adding(passo1)
            passos.adding(passo2)
            passos.adding(passo3)
            passos.adding(passo4)
        
        let preparo1 = Preparo()
        preparo1.nome = "Coado"
        preparo1.imagem = "coffee_press_1.png"
        preparo1.passo = passos
        
        let preparo2 = Preparo()
        preparo2.nome = "Prensa Francesa"
        preparo2.imagem = "pour_over_cone_1.png"
        preparo2.passo = passos
     
        return [preparo1, preparo2]
    }

}
