//
//  Passo.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/23/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class Passo {
    var imagens: [String]
    var descricao: String = ""
    var indice: Int = 0
    var tempo: Int = 0
    var tipo: String = ""
    
    init(indice: Int, tipo: String, tempo: Int, imagens: [String], descricao: String) {
    
        self.indice = indice
        self.tipo = tipo
        self.tempo = tempo
        self.imagens = imagens
        self.descricao = descricao
        
    }
    
    func proximaImagem() {
        
    }
    
    
    
}
