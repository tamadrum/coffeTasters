//
//  OfertasCustomViewCellHeader.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/1/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class OfertasCustomViewCellHeader: UITableViewCell {
    
    @IBOutlet var nome: UILabel?
    @IBOutlet var tipo: UILabel?
    @IBOutlet var valor: UILabel?
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet var valorOferta: UILabel?
    
    @IBOutlet weak var btnComprar: UIButton!
}
