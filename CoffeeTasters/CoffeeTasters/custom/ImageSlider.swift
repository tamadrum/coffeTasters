//
//  ImageSlider.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/1/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ImageSlider: UISlider {

    @IBInspectable var image: UIImage {
        get {
            return currentThumbImage!
        }
        set {
            setThumbImage(newValue, for: .normal)
        }
    }
    
}
