//
//  CheckCreditCardType.swift
//  CoffeeTastersIOS
//
//  Created by Ettore Luglio on 3/21/17.
//  Copyright © 2017 Luglio. All rights reserved.
//

import Foundation
import UIKit
/// Classe para testar algumas informações do cartão de crédito
class CreditCardUtil {
    
    /**
     Este método devolve o tipo do cartão de crédito
     
     ## Important Notes ##
     '*CARD TYPES            *PREFIX           *WIDTH
     'American Express       34, 37            15
     'Diners Club            300 to 305, 36    14
     'Carte Blanche          38                14
     'Discover               6011              16
     'EnRoute                2014, 2149        15
     'JCB                    3                 16
     'JCB                    2131, 1800        15
     'Master Card            51 to 55          16
     'Visa                   4                 13, 16
     
     - Parameter numero: O número do cartão de crédito do sujeito
     - Returns nome da bandeira do cartão de crédito
     
     */
    func creditCardType (_ numero: String) -> String {
        let num = numero.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        
        if num.characters.count < 14 {
            return "Comprimento Inválido"
        }
        
        let inicio2 = Int(num.substring(with: num.index(num.startIndex, offsetBy: 0)..<num.index(num.startIndex, offsetBy: 2)))!
        
        switch (inicio2){
        case 34, 37:
            return "American Express"
        case 36:
            return "Diners Club"
        case 38:
            return "Carte Blanche"
        case 51 , 52, 53, 54, 55:
            return "Master Card"
        default:
            let inicio4 = Int(num.substring(with: num.index(num.startIndex, offsetBy: 0)..<num.index(num.startIndex, offsetBy: 4)))!
            
            switch (inicio4) {
            case 2014, 2149:
                return "EnRoute"
            case 2131, 1800:
                return "JCB"
            case 6011:
                return "Discover"
            default:
                let inicio3 = Int(num.substring(with: num.index(num.startIndex, offsetBy: 0)..<num.index(num.startIndex, offsetBy: 3)))!
                
                switch (inicio3) {
                case 300, 301, 302, 303, 304, 305:
                    return "American Diners Club"
                default:
                    let inicio1 = Int(num.substring(with: num.index(num.startIndex, offsetBy: 0)..<num.index(num.startIndex, offsetBy: 1)))!
                    
                    switch (inicio1) {
                    case 3:
                        return "JCB"
                    case 4:
                        return "Visa"
                    default:
                        return "Número Inválido"
                    }
                }
            }
        }
    }
}
