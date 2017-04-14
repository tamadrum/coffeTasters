//
//  ValidadeCartaoPickerView.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 14/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation
class ValidadeCartaoPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var months: [String] = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var years: [String] = ["2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026"]
    
    var month: Int = 0 {
        didSet {
            selectRow(month, inComponent: 0, animated: false)
        }
    }
    
    var year: Int = 0 {
        didSet {
            selectRow(year, inComponent: 0, animated: false)
        }
    }
    
    var onDateSelected: ((_ month: String, _ year: String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        self.delegate = self
        self.dataSource = self
        
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        self.selectRow(currentMonth - 1, inComponent: 0, animated: false)
        self.selectRow(currentYear, inComponent: 1, animated: false)
    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return years[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let m = months[self.selectedRow(inComponent: 0)]
        let y = years[self.selectedRow(inComponent: 1)]
        
        if let block = onDateSelected {
            block(m, y)
        }
    }
    
}
