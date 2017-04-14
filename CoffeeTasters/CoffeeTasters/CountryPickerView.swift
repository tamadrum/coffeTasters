//
//  CountryPickerView.swift
//  CoffeeTasters
//
//  Created by Rodrigo Luglio on 13/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

//
//  SafraPickerView.swift
//  CoffeeTasters
//
//  Created by Rodrigo Luglio on 13/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import UIKit

class CountryPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var countries: [String]!
    
    var country: Int = 0 {
        didSet {
            selectRow(country, inComponent: 0, animated: false)
        }
    }
    
    var onCountrySelected: ((_ country: Int) -> Void)?
    
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
        var countries: [String] = []
        
        for country in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: country])
            let name = NSLocale(localeIdentifier: Locale.current.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(country)"
            countries.append(name)
        }
        
        self.countries = countries
        
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
            return countries[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return countries.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = self.selectedRow(inComponent: 0)
        if let block = onCountrySelected {
            block(country)
        }
        
        self.country = country
    }
    

    
}

