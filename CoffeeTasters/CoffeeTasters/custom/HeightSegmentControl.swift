//
//  HeightSegmentControl.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 12/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation

@IBDesignable class HeightSegmentControl: UISegmentedControl {
    
    @IBInspectable var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: newValue)
        }
    }
}
