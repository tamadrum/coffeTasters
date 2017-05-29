//
//  CafePickerView.swift
//  CoffeeTasters
//
//  Created by Rodrigo Luglio on 14/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import UIKit

class CafePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var cafeDelegate:SelectCafeProtocol?
    
    var cafes: [Cafe]!
    //var nomes: [String]!
    
    var cafe: Int = 0 {
        didSet {
            selectRow(cafe, inComponent: 0, animated: false)
        }
    }
    
    var onCafeSelected: ((_ cafe: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        
        // population countries with localized names
        var cafes: [Cafe] = []
        //var nomes: [String] = []
        
        for cafe in Dao<Cafe>().list() as [Cafe] {
            //let nome = cafe.nome
            //nomes.append(nome!)
            cafes.append(cafe)
        }
        
        self.cafes = cafes
        
        self.delegate = self
        self.dataSource = self
        
    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return cafes[row].nome
        case 1:
            return cafes[row].pais
        case 2:
            return cafes[row].cidade
        case 3:
            return cafes[row].estado
        case 4:
            return cafes[row].produtor
        case 5:
            return cafes[row].torrador
        case 6:
            return cafes[row].regiao
        case 7:
            return cafes[row].tipo
        case 8:
            return cafes[row].safra
        case 9:
            return String(cafes[row].ehBlend)
        case 10:
            return String(cafes[row].metodo)
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return cafes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cafe = self.selectedRow(inComponent: 0)
        if let block = onCafeSelected {
            block(cafe)
        }
        
        self.cafe = cafe
        cafeDelegate?.atualizaCafeAvaliado(com: cafes[selectedRow(inComponent: 0)])
    }
    
    
    
}


