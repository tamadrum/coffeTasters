//
//  Configuracoes.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/28/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class Configuracoes:NSObject, NSCoding  {
    
    let cores = [UIColor.blue, UIColor.yellow, UIColor.red, UIColor.green, UIColor.black]
    
    var torrador:UIColor = UIColor.blue
    var media: UIColor = UIColor.red
    var usuario: UIColor = UIColor.green
    var nightMode: Bool = false
    
    override init() {

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(torrador, forKey:"torrador")
        aCoder.encode(media, forKey:"media")
        aCoder.encode(usuario, forKey:"usuario")
        aCoder.encode(nightMode, forKey:"nightMode")
    }
    
    required init?(coder aDecoder: NSCoder) {
        torrador = aDecoder.decodeObject(forKey:"torrador") as! UIColor
        media = aDecoder.decodeObject(forKey:"media") as! UIColor
        usuario = aDecoder.decodeObject(forKey:"usuario") as! UIColor
        
        if let nm = aDecoder.decodeObject(forKey:"nightMode") {
            nightMode = nm as! Bool
        } else {
            nightMode = false
        }
    }
}
