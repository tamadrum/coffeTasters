//
//  FlavorViewController.swift
//  CoffeeTastersIOS
//
//  Created by Rodrigo Luglio on 23/02/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import UIKit

class FlavorViewController:UIViewController{
    
    @IBOutlet var doceSlider: UISlider!
    @IBOutlet var azedoSlider: UISlider!
    @IBOutlet var floralSlider: UISlider!
    @IBOutlet var especiariasSlider: UISlider!
    @IBOutlet var salgadoSlider: UISlider!
    @IBOutlet var frutasVermelhasSlider: UISlider!
    @IBOutlet var frutasCitricoSlider: UISlider!
    @IBOutlet var frutasCarocoSlider: UISlider!
    @IBOutlet var chocolateSlider: UISlider!
    @IBOutlet var carameloSlider: UISlider!
    @IBOutlet var defumadoSlider: UISlider!
    @IBOutlet var amargoSlider: UISlider!
    @IBOutlet var herbalSlider: UISlider!
    @IBOutlet var encorpadoSlider: UISlider!
    @IBOutlet var cereaisSlider: UISlider!
    @IBOutlet var nozesSlider: UISlider!

    override func viewDidLoad() {
        doceSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        azedoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        floralSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        especiariasSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        salgadoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        frutasVermelhasSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        frutasCitricoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        frutasCarocoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        chocolateSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        carameloSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        defumadoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        amargoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        herbalSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        encorpadoSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        cereaisSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
        nozesSlider.setThumbImage(UIImage(named: "config.jpg")!, for: .normal)
    }
    
}
