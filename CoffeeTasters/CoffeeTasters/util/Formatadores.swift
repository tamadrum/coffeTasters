//
//  Formatadores.swift
//  CoffeeTasters
//
//  Created by Ettore Luglio on 16/04/17.
//  Copyright © 2017 Tamadrum. All rights reserved.
//

import Foundation

class Formatadores {
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2;
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber);
        return result!;
    }
    
}
