//
//  ConfiguracoesViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class ConfiguracoesViewController:UIViewController{

    @IBOutlet weak var corTorrador: UISegmentedControl!
    @IBOutlet weak var corMedia: UISegmentedControl!
    @IBOutlet weak var corUsuario: UISegmentedControl!
    @IBOutlet weak var isNightMode: UISegmentedControl!
    
    let configuracoes = Configuracoes()
    
    override func viewDidLoad() {
        configuracoes.load()
        
        self.corTorrador.selectedSegmentIndex = configuracoes.cores.index(of: configuracoes.torrador)!
        self.corMedia.selectedSegmentIndex = configuracoes.cores.index(of: configuracoes.media)!
        self.corUsuario.selectedSegmentIndex = configuracoes.cores.index(of: configuracoes.usuario)!
        
        self.isNightMode.selectedSegmentIndex = configuracoes.nightMode ? 0 : 1
    }
    
    @IBAction func salvar(_ sender: Any) {
        configuracoes.torrador = configuracoes.cores[self.corTorrador.selectedSegmentIndex]
        configuracoes.media = configuracoes.cores[self.corMedia.selectedSegmentIndex]
        configuracoes.usuario = configuracoes.cores[self.corUsuario.selectedSegmentIndex]
        
        configuracoes.nightMode = self.isNightMode.selectedSegmentIndex == 1 ? false : true
    
        configuracoes.save()
        
        if let navigator = navigationController {
            navigator.popViewController(animated: true)
        }
    }
}
