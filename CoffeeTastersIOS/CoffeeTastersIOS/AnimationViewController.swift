//
//  AnimationViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var loading1: UIImage!
    var loading2: UIImage!
    var loading3: UIImage!
    
    var images: [UIImage]! = []

    override func viewDidLoad() {
        
        loading1 = UIImage(named: "1")
        loading2 = UIImage(named: "2")
        loading3 = UIImage(named: "3")
        
        images = [loading1, loading2, loading3]
        
        var animatedImage: UIImage!
        
        animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
        
        imageView.image = animatedImage
        
        _ = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    func timeToMoveOn() {
        self.performSegue(withIdentifier: "telaLogin", sender: self)
    }
    
}
