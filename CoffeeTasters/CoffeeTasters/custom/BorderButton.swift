//
//  UICustomButton.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/30/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BorderButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }
    
    @IBInspectable var border: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            clipsToBounds = true
        }
    }
    
    @IBInspectable var fundoBranco: Bool = true {
        didSet {
            if fundoBranco {
                backgroundColor = UIColor.white
            } else {
                backgroundColor = nil
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            self.tintColor = borderColor
        }
    }
    
}
