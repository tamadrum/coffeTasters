//
//  PreparoDao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class PreparoDao: Dao<Preparo> {
    
    func getPreparo() -> [Preparo] {
        let passoDao = Dao<Passo>()
        
        /// Inicio do preparo1
        let preparo1 = new()
        preparo1.nome = "Coado"
        //preparo1.imagem = #imageLiteral(resourceName: "cafe")
        
        let passo1 = passoDao.new()
        passo1.indice = 1
        passo1.tempo = 0
        passo1.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo1.descricao = "Moer os grãos"
        preparo1.addToPasso(passo1)
        
        let passo2 = passoDao.new()
        passo2.indice = 2
        passo2.tempo = 0
        passo2.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo2.descricao = "Colocar o pó no coador"
        preparo1.addToPasso(passo2)
        
        let passo3 = passoDao.new()
        passo3.indice = 3
        passo3.tempo = 0
        passo3.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo3.descricao = "Jogar agua e esperar"
        preparo1.addToPasso(passo3)
        
        let passo4 = passoDao.new()
        passo4.indice = 4
        passo4.tempo = 3
        passo4.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo4.descricao = "Colocar na garrafa térmica"
        preparo1.addToPasso(passo4)
        
        /// Inicio do preparo2
        let preparo2 = new()
        preparo2.nome = "Prensa Francesa"
        //preparo2.imagem = #imageLiteral(resourceName: "cafe")
        
        let passo5 = passoDao.new()
        passo5.indice = 1
        passo5.tempo = 0
        passo5.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo5.descricao = "Moer os grãos"
        preparo2.addToPasso(passo5)
        
        let passo6 = passoDao.new()
        passo6.indice = 2
        passo6.tempo = 0
        passo6.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo6.descricao = "Colocar o pó no coador"
        preparo2.addToPasso(passo6)
        
        let passo7 = passoDao.new()
        passo7.indice = 3
        passo7.tempo = 0
        passo7.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo7.descricao = "Jogar agua e esperar"
        preparo2.addToPasso(passo7)
        
        let passo8 = passoDao.new()
        passo8.indice = 4
        passo8.tempo = 2
        passo8.addToImagens(NSSet(array:[#imageLiteral(resourceName: "cafe")]))
        passo8.descricao = "Colocar na garrafa térmica"
        preparo2.addToPasso(passo8)
        
        return [preparo1, preparo2]
    }
    
}
