//
//  Usuario.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 2/23/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit

class Usuario: NSObject, NSCoding {
    
    var nome: String
    var email: String
    var senha: String
    var perfilPic: String
    var numeroCartao: String
    var nomeCartao: String
    var tipoCartao: String
    var validadeCartao: String
    var cpf: String
    var viuOEULA: Bool
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey:"nome")
        aCoder.encode(email, forKey:"email")
        aCoder.encode(senha, forKey:"senha")
        aCoder.encode(perfilPic, forKey:"perfilPic")
        aCoder.encode(numeroCartao, forKey:"numeroCartao")
        aCoder.encode(nomeCartao, forKey:"nomeCartao")
        aCoder.encode(tipoCartao, forKey:"tipoCartao")
        aCoder.encode(validadeCartao, forKey:"validadeCartao")
        aCoder.encode(cpf, forKey:"cpf")
        aCoder.encode(viuOEULA, forKey:"viuOEULA")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nome = aDecoder.decodeObject(forKey:"nome") as! String
        email = aDecoder.decodeObject(forKey:"email") as! String
        senha = aDecoder.decodeObject(forKey:"senha") as! String
        perfilPic = aDecoder.decodeObject(forKey:"perfilPic") as! String
        numeroCartao = aDecoder.decodeObject(forKey:"numeroCartao") as! String
        nomeCartao = aDecoder.decodeObject(forKey:"nomeCartao") as! String
        tipoCartao = aDecoder.decodeObject(forKey:"tipoCartao") as! String
        validadeCartao = aDecoder.decodeObject(forKey:"validadeCartao") as! String
        cpf = aDecoder.decodeObject(forKey:"cpf") as! String
        viuOEULA = aDecoder.decodeBool(forKey: "viuOEULA")
    }
    
    override init () {
        nome = ""
        email = ""
        senha = ""
        perfilPic = ""
        numeroCartao = ""
        nomeCartao = ""
        tipoCartao = ""
        validadeCartao = ""
        cpf = ""
        viuOEULA = false
    }
    
    func save () {
        print("Salvando usuario con nome: \(nome) - \(email)")
        NSKeyedArchiver.archiveRootObject(self, toFile: getArchive(for:"usuario"))
    }
    
    func load() {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: getArchive(for:"usuario")) {
            let usuario = loaded as! Usuario
            
            self.nome = usuario.nome
            self.email = usuario.email
            self.senha = usuario.senha
            self.perfilPic = usuario.perfilPic
            self.numeroCartao = usuario.numeroCartao
            self.nomeCartao = usuario.nomeCartao
            self.tipoCartao = usuario.tipoCartao
            self.validadeCartao = usuario.validadeCartao
            self.cpf = usuario.cpf
            self.viuOEULA = usuario.viuOEULA
        }
    }
    
    func getArchive(for resource: String) -> String {
        let usersDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = usersDirs[0]
        
        let archive = "\(dir)/coffeetasters-\(resource).dados"
        return archive
    }
    
}
