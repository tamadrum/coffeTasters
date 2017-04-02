//
//  SplashViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/29/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {

    @IBOutlet var logoImageView: UIImageView!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2, animations: {
            self.logoImageView.alpha = 0.0
        })
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    func timeToMoveOn() {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "loginScreen")
        print(storyboard)
        print(view)
        
        present(view, animated: false, completion: nil)
        
    }
    
}
