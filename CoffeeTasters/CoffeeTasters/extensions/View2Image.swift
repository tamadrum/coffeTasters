//
//  View2Image.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 4/10/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}
