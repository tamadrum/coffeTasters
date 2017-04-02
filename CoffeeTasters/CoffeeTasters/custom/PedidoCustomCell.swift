//
//  PedidoCustomCell.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class PedidoCustomCell: UITableViewCell {
    
    @IBOutlet weak var numeroPedido: UILabel!
    @IBOutlet weak var dataPedido: UILabel!
    @IBOutlet weak var imagemStatusPedido: UIImageView!
    @IBOutlet weak var totalPedido: UILabel!
    
    
    @IBAction func comprarNovamente(_ sender: UIButton) {
    }
    
}
