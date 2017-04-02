//
//  DetalhesCafeController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class DetalhesCafeController: UIViewController {
    
    @IBOutlet weak var torradorLabel: UILabel!
    @IBOutlet weak var produtorLabel: UILabel!
    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var cidadeLabel: UILabel!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var tipoCafeLabel: UILabel!
    @IBOutlet weak var alturaLabel: UILabel!
    @IBOutlet weak var safraLabel: UILabel!
    @IBOutlet weak var comentarioTextView: UITextView!
    @IBOutlet weak var notaQuatroLabel: UILabel!
    @IBOutlet weak var notaTresLabel: UILabel!
    @IBOutlet weak var notaDoisLabel: UILabel!
    @IBOutlet weak var notaUmLabel: UILabel!
    @IBOutlet weak var rodaSabores: WheelFlavor!
    @IBOutlet weak var torradorMediaSegmentControl: UISegmentedControl!
    @IBOutlet weak var avaliacoesAntigasSegmentControl: UISegmentedControl!
    
    @IBAction func verMapa(_ sender: UIButton) {
    }
    
    @IBAction func comprarCafe(_ sender: Any) {
    }
}
