//
//  AvaliacoesViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit
import Social

class AvaliacoesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView?
    var avaliacoes:[Avaliacao] = []
    
    var nomeToShare: String!
    var ratingToShare: Float!
    var imageToShare:UIImage!
    
    // MARK: Ciclo de vida
    
    override func viewDidLoad() {
        let dao = Dao<Avaliacao>()
        avaliacoes = dao.list()
    }
    
    // MARK: Coisas de tabela
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avaliacoes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! AvaliacaoCustomCell
        
        cell.comentario.text = avaliacoes[indexPath.row].obs
        cell.flavor.flavorUsuario = avaliacoes[indexPath.row].flavor
        cell.modoPrepado.text = avaliacoes[indexPath.row].metodoPreparo
        cell.nomeCafe.text = avaliacoes[indexPath.row].cafe?.nome
        cell.rating.rating = Float(avaliacoes[indexPath.row].gostou)
        cell.safra.text = avaliacoes[indexPath.row].data
        
        imageToShare = UIImage.init(view: cell.flavor)
        nomeToShare = (avaliacoes[indexPath.row].cafe?.nome)!
        ratingToShare = Float(avaliacoes[indexPath.row].gostou)
        cell.share.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func share() {
        let usuario = Usuario()
        usuario.load()
        let textoParaPublicar = "\(usuario.nome) avaliou um novo café: \(nomeToShare!) \n Avaliação: \(ratingToShare!)/4.0 \n"
        
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        vc?.setInitialText("Aonde isso vai?")
        vc?.add(imageToShare)
        vc?.add(URL(string: "http://www.coffeetasters.com.br/")!)
        vc?.setInitialText(textoParaPublicar)
        
        navigationController?.present(vc!, animated: true, completion: nil)
        
    }
    
}
