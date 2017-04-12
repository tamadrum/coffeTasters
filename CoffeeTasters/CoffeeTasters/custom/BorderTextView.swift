//
//  BorderTextView.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 12/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation

@IBDesignable
class BorderTextView: UITextView {
    
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
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            self.tintColor = borderColor
        }
    }
    
}
