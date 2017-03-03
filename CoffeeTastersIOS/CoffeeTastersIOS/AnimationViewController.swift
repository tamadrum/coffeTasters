//
//  AnimationViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet var loadingImageView: UIImageView!
    
    var loading1: UIImage!
    var loading2: UIImage!
    var loading3: UIImage!
    var loading4: UIImage!
    var loading5: UIImage!
    
    var images: [UIImage]! = []

    override func viewDidLoad() {
        
        loading1 = UIImage(named: "coffee_press_1")
        loading2 = UIImage(named: "coffee_press_2")
        loading3 = UIImage(named: "coffee_press_3")
        loading4 = UIImage(named: "coffee_press_4")
        loading5 = UIImage(named: "coffee_press_5")
        
        images = [loading1, loading2, loading3, loading4, loading5]
        
        var animatedImage: UIImage!
        
        animatedImage = UIImage.animatedImage(with: images, duration: 0.5)
        
        loadingImageView.image = animatedImage
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    func timeToMoveOn() {
        self.performSegue(withIdentifier: "telaLogin", sender: self)
    }
    
}
