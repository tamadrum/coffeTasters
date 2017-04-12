//
//  AvaliacaoViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class AvaliacaoViewController: UIViewController {
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var paisTextField: UITextField!
    @IBOutlet weak var cidadeTextField: UITextField!
    @IBOutlet weak var estadoTextField: UITextField!
    @IBOutlet weak var produtorTextField: UITextField!
    @IBOutlet weak var torradorTextField: UITextField!
    @IBOutlet weak var regiaoTextField: UITextField!
    @IBOutlet weak var tipoTextField: UITextField!
    @IBOutlet weak var safraTextField: UITextField!
    @IBOutlet weak var localPreparoTextField: UITextField!
    @IBOutlet weak var baristaTextField: UITextField!
    @IBOutlet weak var metodoPreparoSegmentControl: UISegmentedControl!
    @IBOutlet weak var doceSlider: UISlider!
    @IBOutlet weak var azedoSlider: UISlider!
    @IBOutlet weak var floralSlider: UISlider!
    @IBOutlet weak var especiariasSlider: UISlider!
    @IBOutlet weak var salgadoSlider: UISlider!
    @IBOutlet weak var frutasVermelhasSlider: UISlider!
    @IBOutlet weak var frutasCitricasSlider: UISlider!
    @IBOutlet weak var frutasCarocoSlider: UISlider!
    @IBOutlet weak var chocolateSlider: UISlider!
    @IBOutlet weak var carameloSlider: UISlider!
    @IBOutlet weak var defumadoSlider: UISlider!
    @IBOutlet weak var amargoSlider: UISlider!
    @IBOutlet weak var herbalSlider: UISlider!
    @IBOutlet weak var encorpadoSlider: UISlider!
    @IBOutlet weak var cereaisSlider: UISlider!
    @IBOutlet weak var nozesSlider: UISlider!
    @IBOutlet weak var comentariosTextView: UITextView!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var cafeBlendSegmentControl: UISegmentedControl!
    
    var cafeAvaliado: Cafe!
}
