//
//  AvaliacaoViewController.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 3/31/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
import UIKit

class AvaliacaoViewController: UIViewController, SelectCafeProtocol {
    
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
    @IBOutlet weak var buscaCafeButton: UIButton!
    
    var cafeAvaliado: Cafe?
    
    //Barra de controle para os pickers
    var inputAcessoryBar: UIToolbar!
    var inputAcessoryBarCountry: UIToolbar!
    
    override func viewDidLoad() {
        if let cafeAvaliado = cafeAvaliado {
            nomeTextField.text = cafeAvaliado.nome
            paisTextField.text = cafeAvaliado.pais
            cidadeTextField.text = cafeAvaliado.cidade
            estadoTextField.text = cafeAvaliado.estado
            produtorTextField.text = cafeAvaliado.produtor
            torradorTextField.text = cafeAvaliado.torrador
            regiaoTextField.text = cafeAvaliado.regiao
            tipoTextField.text = cafeAvaliado.tipo
            safraTextField.text = cafeAvaliado.safra
            cafeBlendSegmentControl.selectedSegmentIndex = 0
            
        }
        
        //Safra Picker
        let safraPickerView = SafraPickerView()
        safraPickerView.onDateSelected = { (month: Int, year: Int) in
            self.safraTextField.text = String(format: "%02d/%d", month, year)
        }
        
        initializeInputAccessoryBar()
        
        safraTextField.inputView = safraPickerView
        safraTextField.inputAccessoryView = inputAcessoryBar
        
        //País Picker
        let countryPickerView = CountryPickerView()
        countryPickerView.onCountrySelected = { (country: Int) in
            
            self.paisTextField.text = countryPickerView.pickerView(countryPickerView, titleForRow: country, forComponent: 0)
            
        }

        initializeInputAccessoryBarCountry()
        
        paisTextField.inputView = countryPickerView
        paisTextField.inputAccessoryView = inputAcessoryBarCountry
        
        //Café Picker
        let cafePickerView = CafePickerView()
        cafePickerView.cafeDelegate = self
        cafePickerView.onCafeSelected = { (cafe: Int) in
            
            self.nomeTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 0)
            self.paisTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 1)
            self.cidadeTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 2)
            self.estadoTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 3)
            self.produtorTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 4)
            self.torradorTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 5)
            self.regiaoTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 6)
            self.tipoTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 7)
            self.safraTextField.text = cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 8)
            
            if Bool(cafePickerView.pickerView(cafePickerView, titleForRow: cafe, forComponent: 9)!) == true {
                self.cafeBlendSegmentControl.selectedSegmentIndex = 1
            } else {
                self.cafeBlendSegmentControl.selectedSegmentIndex = 0
            }
            
        }
        
        initializeInputAccessoryBarCafe()
        
        nomeTextField.inputView = cafePickerView
        nomeTextField.inputAccessoryView = inputAcessoryBar
        
        
        
    }
    
    @IBAction func salvarAvaliacao(_ sender: UIBarButtonItem) {
        let dao = Dao<Avaliacao>()
        
        let avaliacao = dao.new()
        avaliacao.cafe = cafeAvaliado
        avaliacao.barista = baristaTextField.text
        avaliacao.data = "20/10/2017"
        avaliacao.dataColheita = "10/10/2017"
        avaliacao.dataTorra = "12/10/2017"
        avaliacao.flavor = Dao<Flavor>().new()
        avaliacao.flavor?.doce = Int32(doceSlider.value)
        avaliacao.flavor?.azedo = Int32(azedoSlider.value)
        avaliacao.flavor?.floral = Int32(floralSlider.value)
        avaliacao.flavor?.especiarias = Int32(especiariasSlider.value)
        avaliacao.flavor?.salgado = Int32(salgadoSlider.value)
        avaliacao.flavor?.frutasVermelhas = Int32(frutasVermelhasSlider.value)
        avaliacao.flavor?.frutasCitricas = Int32(frutasCitricasSlider.value)
        avaliacao.flavor?.frutasCaroco = Int32(frutasCarocoSlider.value)
        avaliacao.flavor?.chocolate = Int32(chocolateSlider.value)
        avaliacao.flavor?.caramelo = Int32(carameloSlider.value)
        avaliacao.flavor?.defumado = Int32(defumadoSlider.value)
        avaliacao.flavor?.amargo = Int32(amargoSlider.value)
        avaliacao.flavor?.herbal = Int32(herbalSlider.value)
        avaliacao.flavor?.encorpado = Int32(encorpadoSlider.value)
        avaliacao.flavor?.cereais = Int32(cereaisSlider.value)
        avaliacao.flavor?.nozes = Int32(nozesSlider.value)
        avaliacao.gostou = Int32(rating.rating)
        avaliacao.localPreparo = localPreparoTextField.text
        avaliacao.metodoPreparo = "\(metodoPreparoSegmentControl.selectedSegmentIndex)"
        avaliacao.obs = comentariosTextView.text
        
        dao.save()
        
        if let nav = navigationController {
            nav.popToRootViewController(animated: true)
        }
    }
    
    //Configuração Safra Picker
    func initializeInputAccessoryBar() {
        inputAcessoryBar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissSafraPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBar.items = [flexibleSpace, doneButton]
    }
    
    func dismissSafraPicker() {
        safraTextField.resignFirstResponder()
    }
    
    //Configuração País Picker
    func initializeInputAccessoryBarCountry() {
        inputAcessoryBarCountry = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissCountryPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBarCountry.items = [flexibleSpace, doneButton]
    }
    
    func dismissCountryPicker() {
        paisTextField.resignFirstResponder()
    }
    
    //Configuração Café Picker
    func initializeInputAccessoryBarCafe() {
        inputAcessoryBar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissCafePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBar.items = [flexibleSpace, doneButton]
    }
    
    func dismissCafePicker() {
        nomeTextField.resignFirstResponder()
    }
    
    //Habilita ou desabilita o safraTextField
    @IBAction func toggleSafra(_ sender: Any) {
        switch cafeBlendSegmentControl.selectedSegmentIndex {
            case 0:
                safraTextField.isUserInteractionEnabled = true
                safraTextField.text = "Selecione"
            case 1:
                safraTextField.isUserInteractionEnabled = false
                safraTextField.text = "Sem safra"
            default:
                break
        }
    }
    
    @IBAction func buscaCafe(_ sender: Any) {
        nomeTextField.becomeFirstResponder()
    }
    
    func atualizaCafeAvaliado(com: Cafe) {
        cafeAvaliado = com
    }

}
