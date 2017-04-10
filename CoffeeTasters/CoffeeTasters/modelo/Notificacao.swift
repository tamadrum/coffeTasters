//
//  Notificacao.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/10/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import ObjectMapper

class Notificacao: Mappable {
    var tipo: Int!
    var mensagem: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        tipo        <- map["tipo"]
        mensagem    <- map["mensagem"]
    }
}
