//
//  SafraPickerView.swift
//  CoffeeTasters
//
//  Created by Rodrigo Luglio on 13/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import UIKit

class SafraPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var safras: [String]!
    
    var safra: Int = 0 {
    
        didSet {
        
            selectRow(safra, inComponent: 0, animated: false)
        }
    }

    var onSafraSelected: ((_ safra: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {

        //population safras
        var safras:[String] = []
        var months = [0,4,8]
        //var years: [Int] = [0,1]
        
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date) as Int
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date) as Int

        if currentMonth >= 9 {

            if safras.count == 0 {
            
                for x in 0...2 {
                    
                    safras.append("\(DateFormatter().monthSymbols[months[x]].capitalized) " + "\(currentYear - 1)")
                    
                    
                }
                
                for x in 0...2 {
                    
                    safras.append("\(DateFormatter().monthSymbols[months[x]].capitalized) " + "\(currentYear)")
                    
                    
                    }
                }
            
        }
        
        if currentMonth < 9 && currentMonth >= 5 {
            
            if safras.count == 0 {
                    
                safras.append("\(DateFormatter().monthSymbols[months[2]].capitalized) " + "\(currentYear - 2)")
                
                for x in 0...2 {
                    
                    safras.append("\(DateFormatter().monthSymbols[months[x]].capitalized) " + "\(currentYear - 1)")
                    
                    
                }
                
                for x in 0...1 {
                        
                        safras.append("\(DateFormatter().monthSymbols[months[x]].capitalized) " + "\(currentYear)")
                        
                        
                }
                    
                
                
                
            }
            
        }
        
        if currentMonth < 5 {
                
            if safras.count == 0 {
                
                for x in 1...2 {
                    
                    safras.append("\(DateFormatter().monthSymbols[months[x]].capitalized) " + "\(currentYear - 2)")
                    
                    
                }
                for x in 0...2 {
                    
                    safras.append("\(DateFormatter().monthSymbols[months[x]].capitalized) " + "\(currentYear - 1)")
                    
                    
                }
                
                safras.append("\(DateFormatter().monthSymbols[months[0]].capitalized) " + "\(currentYear)")
                        
                        
            }
                    
        }

            
        self.safras = safras
        
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
            return safras[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return safras.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let safra = self.selectedRow(inComponent: 0)
        if let block = onSafraSelected {
            block(safra)
        }
        
        self.safra = safra
    }
    
}
