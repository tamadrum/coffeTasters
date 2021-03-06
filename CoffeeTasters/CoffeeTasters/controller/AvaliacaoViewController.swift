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
    @IBOutlet weak var metodoSegmentControl: UISegmentedControl!
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
    
    var delegate:UpdateAvaliacoesProtocol?
    
    var listaTextoModoPreparo = ["Prensa", "Espresso", "Coado", "Moca", "Aeropress", "Clever"]
    
    var cafeAvaliado: Cafe?
    
    var criaNovoCafe = true
    
    //Barra de controle para os pickers
    var inputAcessoryBar: UIToolbar!
    var inputAcessoryBarCountry: UIToolbar!

    var inputAcessoryBarCafe: UIToolbar!
    
    let cafePickerView = CafePickerView()
    let safraPickerView = SafraPickerView()
    let countryPickerView = CountryPickerView()
    
    override func viewDidLoad() {
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
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
            metodoSegmentControl.selectedSegmentIndex = 0
            
            print("Trocando o criaNovoCafe para false")
            criaNovoCafe = false
            
        }
        
        //Safra Picker
        self.safraPickerView.onSafraSelected = { (safra: Int) in
            self.safraTextField.text = self.safraPickerView.pickerView(self.safraPickerView, titleForRow: safra, forComponent: 0)
        }
        
        initializeInputAccessoryBar()
        
        safraTextField.inputView = safraPickerView
        safraTextField.inputAccessoryView = inputAcessoryBar
        
        
        //País Picker
        self.countryPickerView.onCountrySelected = { (country: Int) in
            
            self.paisTextField.text = self.countryPickerView.pickerView(self.countryPickerView, titleForRow: country, forComponent: 0)
            
        }

        initializeInputAccessoryBarCountry()
        
        paisTextField.inputView = countryPickerView
        paisTextField.inputAccessoryView = inputAcessoryBarCountry
        
        
        //Café Picker
        cafePickerView.cafeDelegate = self
        cafePickerView.onCafeSelected = { (cafe: Int) in

            
            self.nomeTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 0)
            self.paisTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 1)
            self.cidadeTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 2)
            self.estadoTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 3)
            self.produtorTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 4)
            self.torradorTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 5)
            self.regiaoTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 6)
            self.tipoTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 7)
            self.safraTextField.text = self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 8)
            
            if Bool(self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 9)!) == true {
                self.cafeBlendSegmentControl.selectedSegmentIndex = 1
            } else {
                self.cafeBlendSegmentControl.selectedSegmentIndex = 0
            }
            if Bool(self.cafePickerView.pickerView(self.cafePickerView, titleForRow: cafe, forComponent: 10)!) == true {
                self.metodoSegmentControl.selectedSegmentIndex = 1
            } else {
                self.metodoSegmentControl.selectedSegmentIndex = 0
            }
            
            print("Trocando o criaNovoCafe para false")
            self.criaNovoCafe = false
            
        }
        
        initializeInputAccessoryBarCafe()
        
//        nomeTextField.inputView = cafePickerView
//        nomeTextField.inputAccessoryView = inputAcessoryBar
        
    }
    
    @IBAction func salvarAvaliacao(_ sender: UIBarButtonItem) {
        // TODO: Tem que escolher quando vai adicionar o café ou não
        
        if ( criaNovoCafe ) {
            print("Tive que criar um café nessa avaliacao")
            let cafeDao = Dao<Cafe>()
            
            let cafe = cafeDao.new()
            cafe.nome = nomeTextField.text
            cafe.pais = paisTextField.text
            cafe.cidade = cidadeTextField.text
            cafe.estado = estadoTextField.text
            cafe.produtor = produtorTextField.text
            cafe.torrador = torradorTextField.text
            cafe.regiao = regiaoTextField.text
            cafe.tipo = tipoTextField.text
            cafe.safra = safraTextField.text
            cafe.ehBlend = cafeBlendSegmentControl.selectedSegmentIndex == 0 ? false : true
            cafe.metodo = metodoSegmentControl.selectedSegmentIndex == 0 ? false : true
            
            cafeDao.save()
            
            cafeAvaliado = cafe
        }
        
        let daoFlavor = Dao<Flavor>()
        
        let meuFlavor = daoFlavor.new()
        meuFlavor.doce = Int32(doceSlider.value)
        meuFlavor.azedo = Int32(azedoSlider.value)
        meuFlavor.floral = Int32(floralSlider.value)
        meuFlavor.especiarias = Int32(especiariasSlider.value)
        meuFlavor.salgado = Int32(salgadoSlider.value)
        meuFlavor.frutasVermelhas = Int32(frutasVermelhasSlider.value)
        meuFlavor.frutasCitricas = Int32(frutasCitricasSlider.value)
        meuFlavor.frutasCaroco = Int32(frutasCarocoSlider.value)
        meuFlavor.chocolate = Int32(chocolateSlider.value)
        meuFlavor.caramelo = Int32(carameloSlider.value)
        meuFlavor.defumado = Int32(defumadoSlider.value)
        meuFlavor.amargo = Int32(amargoSlider.value)
        meuFlavor.herbal = Int32(herbalSlider.value)
        meuFlavor.encorpado = Int32(encorpadoSlider.value)
        meuFlavor.cereais = Int32(cereaisSlider.value)
        meuFlavor.nozes = Int32(nozesSlider.value)
        
        let flavorMedia = daoFlavor.new()
        flavorMedia.doce = Int32(5)
        flavorMedia.azedo = Int32(7)
        flavorMedia.floral = Int32(9)
        flavorMedia.especiarias = Int32(3)
        flavorMedia.salgado = Int32(1)
        flavorMedia.frutasVermelhas = Int32(8)
        flavorMedia.frutasCitricas = Int32(6)
        flavorMedia.frutasCaroco = Int32(4)
        flavorMedia.chocolate = Int32(2)
        flavorMedia.caramelo = Int32(8)
        flavorMedia.defumado = Int32(5)
        flavorMedia.amargo = Int32(1)
        flavorMedia.herbal = Int32(3)
        flavorMedia.encorpado = Int32(9)
        flavorMedia.cereais = Int32(1)
        flavorMedia.nozes = Int32(8)

        daoFlavor.save()

        let dao = Dao<Avaliacao>()
        
        let avaliacao = dao.new()
        avaliacao.cafe = cafeAvaliado
        avaliacao.barista = baristaTextField.text
        avaliacao.data = "20/10/2017"
        avaliacao.dataColheita = "10/10/2017"
        avaliacao.dataTorra = "12/10/2017"
        
        avaliacao.flavor = meuFlavor
        avaliacao.flavorMedia = flavorMedia
        
        avaliacao.gostou = Int32(rating.rating)
        avaliacao.localPreparo = localPreparoTextField.text
        avaliacao.metodoPreparo = listaTextoModoPreparo[metodoPreparoSegmentControl.selectedSegmentIndex]
        avaliacao.obs = comentariosTextView.text
        
        dao.save()
        
        if let nav = navigationController {
            delegate?.atualizarListaProtocol()
            nav.popToRootViewController(animated: true)
        }
    }
    
    //Configuração Safra Picker
    func initializeInputAccessoryBar() {
        inputAcessoryBar = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissSafraPicker))
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelSafraPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBar.items = [cancelButton, flexibleSpace, doneButton]
    }
    
    func dismissSafraPicker() {
        self.safraPickerView.pickerView(self.safraPickerView, didSelectRow: self.safraPickerView.selectedRow(inComponent: 0), inComponent: 0)
        safraTextField.resignFirstResponder()
    }
    func cancelSafraPicker() {
        safraTextField.resignFirstResponder()
        safraTextField.text = ""
    }
    
    //Configuração País Picker
    func initializeInputAccessoryBarCountry() {
        inputAcessoryBarCountry = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissCountryPicker))
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelPaisPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBarCountry.items = [cancelButton, flexibleSpace, doneButton]
    }
    
    func dismissCountryPicker() {
        self.countryPickerView.pickerView(self.countryPickerView, didSelectRow: self.countryPickerView.selectedRow(inComponent: 0), inComponent: 0)
        paisTextField.resignFirstResponder()
    }
    func cancelPaisPicker() {
        paisTextField.resignFirstResponder()
        paisTextField.text = ""
    }
    
    //Configuração Café Picker
    func initializeInputAccessoryBarCafe() {
        inputAcessoryBarCafe = UIToolbar(frame: CGRect(x: 0, y:0, width: view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissCafePicker))
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelCafePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        inputAcessoryBarCafe.items = [cancelButton, flexibleSpace, doneButton]
    }
    
    func dismissCafePicker() {
        nomeTextField.resignFirstResponder()
        nomeTextField.inputView = nil
        nomeTextField.inputAccessoryView = nil
        nomeTextField.reloadInputViews()
        
        self.nomeTextField.isUserInteractionEnabled = false
        self.paisTextField.isUserInteractionEnabled = false
        self.cidadeTextField.isUserInteractionEnabled = false
        self.estadoTextField.isUserInteractionEnabled = false
        self.produtorTextField.isUserInteractionEnabled = false
        self.torradorTextField.isUserInteractionEnabled = false
        self.regiaoTextField.isUserInteractionEnabled = false
        self.tipoTextField.isUserInteractionEnabled = false
        self.safraTextField.isUserInteractionEnabled = true
        self.cafeBlendSegmentControl.isUserInteractionEnabled = false
        self.metodoSegmentControl.isUserInteractionEnabled = false
        
    }
    
    func cancelCafePicker() {
        nomeTextField.resignFirstResponder()
        nomeTextField.inputView = nil
        nomeTextField.inputAccessoryView = nil
        nomeTextField.reloadInputViews()
        
        self.nomeTextField.text = ""
        self.paisTextField.text = ""
        self.cidadeTextField.text = ""
        self.estadoTextField.text = ""
        self.produtorTextField.text = ""
        self.torradorTextField.text = ""
        self.regiaoTextField.text = ""
        self.tipoTextField.text = ""
        self.safraTextField.text = ""
        self.cafeBlendSegmentControl.selectedSegmentIndex = 0
        self.metodoSegmentControl.selectedSegmentIndex = 0
        
        self.nomeTextField.isUserInteractionEnabled = true
        self.paisTextField.isUserInteractionEnabled = true
        self.cidadeTextField.isUserInteractionEnabled = true
        self.estadoTextField.isUserInteractionEnabled = true
        self.produtorTextField.isUserInteractionEnabled = true
        self.torradorTextField.isUserInteractionEnabled = true
        self.regiaoTextField.isUserInteractionEnabled = true
        self.tipoTextField.isUserInteractionEnabled = true
        self.safraTextField.isUserInteractionEnabled = true
        self.cafeBlendSegmentControl.isUserInteractionEnabled = true
        self.metodoSegmentControl.isUserInteractionEnabled = true
        
        print("Trocando o criaNovoCafe para true")
        criaNovoCafe = true
        
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
        self.nomeTextField.isUserInteractionEnabled = true
        self.paisTextField.isUserInteractionEnabled = true
        self.cidadeTextField.isUserInteractionEnabled = true
        self.estadoTextField.isUserInteractionEnabled = true
        self.produtorTextField.isUserInteractionEnabled = true
        self.torradorTextField.isUserInteractionEnabled = true
        self.regiaoTextField.isUserInteractionEnabled = true
        self.tipoTextField.isUserInteractionEnabled = true
        self.safraTextField.isUserInteractionEnabled = true
        self.cafeBlendSegmentControl.isUserInteractionEnabled = true
        self.metodoSegmentControl.isUserInteractionEnabled = true
        
        nomeTextField.resignFirstResponder()
        nomeTextField.inputView = cafePickerView
        nomeTextField.inputAccessoryView = inputAcessoryBarCafe
        nomeTextField.becomeFirstResponder()
        
        cafePickerView.pickerView(self.cafePickerView, didSelectRow: 0, inComponent: 0)
        
    }
    
    func atualizaCafeAvaliado(com: Cafe) {
        cafeAvaliado = com
    }

}
