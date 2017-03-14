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
        let images:[UIImage] = [UIImage(named: "coffee_press_1")!,
                      UIImage(named: "coffee_press_2")!,
                      UIImage(named: "coffee_press_3")!,
                      UIImage(named: "coffee_press_4")!,
                      UIImage(named: "coffee_press_5")!]
        
        var animatedImage: UIImage!
        
        animatedImage = UIImage.animatedImage(with: images, duration: 0.5)
        
        loadingImageView.image = animatedImage
        
        SyncUtil().getDadosFrom(url: "http://www.kaleidosblog.com/tutorial/tutorial.json",
                                trataJson: { (result: Data) in
                                    _ = SyncUtil().extract_json(jsonData: result)
                                    //print("got back: \(r)")
                                    return ""
        },
                                finish: { (dados: Any) in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                        self.timeToMoveOn()
                                    })
        })
//        
//        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    func timeToMoveOn() {
        self.performSegue(withIdentifier: "telaLogin", sender: self)
    }
    
}
