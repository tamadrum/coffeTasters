//
//  OfertaCustomCell.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class OfertaCustomCell: UITableViewCell {
   
    @IBOutlet weak var nomeProdutoLabel: UILabel!
    @IBOutlet weak var pequenaDescricaoLabel: UILabel!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var valorCheio: UILabel!
    @IBOutlet weak var valorDesconto: UILabel!
    @IBOutlet weak var imagemLogoCafe: UIImageView!
    
    @IBAction func Comprar(_ sender: UIButton) {
    }
    
}
