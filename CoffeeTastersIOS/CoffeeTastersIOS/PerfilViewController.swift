//
//  PerfilViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class PerfilViewController:UIViewController{
    
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var emailUsuario: UILabel!
    
    var usuario:Usuario = Dao().load()
    
    @IBOutlet weak var qtdAvaliacoes: UILabel!
    @IBOutlet weak var qtdCafes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nomeUsuario.text = usuario.nome
        emailUsuario.text = usuario.email
        
        if let url = URL(string:usuario.perfilPic) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.sync() {
                    self.imgPerfil.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "meusDados") {
            let view = segue.destination as! MeusDadosViewController
            view.carregaUsuario(usuario)
        }
    }
    
}
