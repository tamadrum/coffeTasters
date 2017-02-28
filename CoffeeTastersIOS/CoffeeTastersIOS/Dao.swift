//
//  Dao.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/24/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation

class Dao {
    
    func save(_ configuracoes: Configuracoes) {
        NSKeyedArchiver.archiveRootObject(configuracoes, toFile: getArchive(for:"configuracoes"))
    }
    
    func load() -> Configuracoes {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: getArchive(for:"configuracoes")) {
            let configuracoes = loaded as! Configuracoes
            return configuracoes
        }
        return Configuracoes()
    }
    
    func save (_ usuario: Usuario) {
        NSKeyedArchiver.archiveRootObject(usuario, toFile: getArchive(for:"usuario"))
    }
    
    func load() -> Usuario {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: getArchive(for:"usuario")) {
            let usuario = loaded as! Usuario
            return usuario
        }
        return Usuario()
    }
    
    func getArchive(for resource: String) -> String {
        let usersDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = usersDirs[0]
        
        let archive = "\(dir)/coffeetasters-\(resource).dados"
        return archive
    }

}
