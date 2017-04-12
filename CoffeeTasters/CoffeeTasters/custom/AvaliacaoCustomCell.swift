//
//  AvaliacaoCustomCell.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/2/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class AvaliacaoCustomCell: UITableViewCell {
    
    @IBOutlet weak var modoPrepado: UILabel!
    @IBOutlet weak var safra: UILabel!
    @IBOutlet weak var comentario: UITextView!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var flavor: WheelFlavor!
    @IBOutlet weak var nomeCafe: UILabel!
    @IBOutlet weak var share: BorderButton!
    
}
