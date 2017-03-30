//
//  MeusDadosViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/29/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class MeusDadosViewController: UIViewController {
    
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        pop()
    }
    
    @IBAction func salvar(_ sender: UIBarButtonItem) {
        pop()
    }
    
    func pop () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "tabPrincipal")
        print(storyboard)
        print(view)
        
        present(view, animated: true, completion: nil)
    }
    
}
