//
//  Configuracoes.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class Usuario: NSObject, NSCoding {
    
    var nome: String
    var sobrenome:String
    var email: String
    var senha: String
    var perfilImg: String
    var imagem: UIImage?
    var numeroCartao: String
    var nomeCartao: String
    var validadeCartao: String
    var cpf: String
    var viuEULA: Bool
    var querNotificacao: Bool
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey:"nome")
        aCoder.encode(sobrenome, forKey:"sobrenome")
        aCoder.encode(email, forKey:"email")
        aCoder.encode(senha, forKey:"senha")
        aCoder.encode(perfilImg, forKey:"perfilImg")
        aCoder.encode(imagem, forKey:"imagem")
        aCoder.encode(numeroCartao, forKey:"numeroCartao")
        aCoder.encode(nomeCartao, forKey:"nomeCartao")
        aCoder.encode(validadeCartao, forKey:"validadeCartao")
        aCoder.encode(cpf, forKey:"cpf")
        aCoder.encode(viuEULA, forKey:"viuEULA")
        aCoder.encode(querNotificacao, forKey:"querNotificacao")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nome = aDecoder.decodeObject(forKey:"nome") as! String
        sobrenome = aDecoder.decodeObject(forKey:"sobrenome") as! String
        email = aDecoder.decodeObject(forKey:"email") as! String
        senha = aDecoder.decodeObject(forKey:"senha") as! String
        perfilImg = aDecoder.decodeObject(forKey:"perfilImg") as! String
        imagem = aDecoder.decodeObject(forKey:"imagem") as? UIImage
        numeroCartao = aDecoder.decodeObject(forKey:"numeroCartao") as! String
        nomeCartao = aDecoder.decodeObject(forKey:"nomeCartao") as! String
        validadeCartao = aDecoder.decodeObject(forKey:"validadeCartao") as! String
        cpf = aDecoder.decodeObject(forKey:"cpf") as! String
        viuEULA = aDecoder.decodeBool(forKey: "viuEULA")
        querNotificacao = aDecoder.decodeBool(forKey: "querNotificacao")
    }
    
    override init () {
        nome = ""
        sobrenome = ""
        email = ""
        senha = ""
        perfilImg = ""
        imagem = #imageLiteral(resourceName: "person")
        numeroCartao = ""
        nomeCartao = ""
        validadeCartao = ""
        cpf = ""
        viuEULA = false
        querNotificacao = true
    }
    
    func save () {
        NSKeyedArchiver.archiveRootObject(self, toFile: getArchive(for:"usuario"))
    }
    
    func load() {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: getArchive(for:"usuario")) {
            let usuario = loaded as! Usuario
            
            self.nome = usuario.nome
            self.sobrenome = usuario.sobrenome
            self.email = usuario.email
            self.senha = usuario.senha
            self.perfilImg = usuario.perfilImg
            self.imagem = usuario.imagem
            self.numeroCartao = usuario.numeroCartao
            self.nomeCartao = usuario.nomeCartao
            self.validadeCartao = usuario.validadeCartao
            self.cpf = usuario.cpf
            self.viuEULA = usuario.viuEULA
            self.querNotificacao = usuario.querNotificacao
        }
    }
    
    func getArchive(for resource: String) -> String {
        let usersDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = usersDirs[0]
        
        let archive = "\(dir)/coffeetasters-\(resource).dados"
        return archive
    }
}
