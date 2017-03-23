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

    override func viewDidLoad() {
        
        let images:[UIImage] = [#imageLiteral(resourceName: "coffee_press_1"),
                      #imageLiteral(resourceName: "coffee_press_2"),
                      #imageLiteral(resourceName: "coffee_press_3"),
                      #imageLiteral(resourceName: "coffee_press_4"),
                      #imageLiteral(resourceName: "coffee_press_5")]
       
        
        
        var animatedImage: UIImage!
        
        animatedImage = UIImage.animatedImage(with: images, duration: 0.5)
        
        loadingImageView.image = animatedImage
        
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    func timeToMoveOn() {
        self.performSegue(withIdentifier: "telaLogin", sender: self)
    }
    
}
