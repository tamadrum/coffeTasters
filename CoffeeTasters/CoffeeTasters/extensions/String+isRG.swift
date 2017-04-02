import Foundation

extension String {
    
    func isRG() -> Bool {
        var qtd = 9
        let rg = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        var i = rg.characters.count - 2
        var resultado = 0
        
        while ( i >= 0 ) {
            resultado += Int(rg.substring(with: rg.index(rg.startIndex, offsetBy: i)..<rg.index(rg.startIndex, offsetBy: i+1)))!*qtd
            qtd -= 1
            i -= 1
        }
        
        let posicao1 = rg.index(rg.startIndex, offsetBy: rg.characters.count-1)
        let posicao2 = rg.index(rg.startIndex, offsetBy: rg.characters.count-2)
        
        if ( ( resultado + 100 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 1 }
        if ( ( resultado + 200 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 2 }
        if ( ( resultado + 300 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 3 }
        if ( ( resultado + 400 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 4 }
        if ( ( resultado + 500 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 5 }
        if ( ( resultado + 600 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 6 }
        if ( ( resultado + 700 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 7 }
        if ( ( resultado + 800 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 8 }
        if ( ( resultado + 900 ) % 11 == 0) { return Int(rg.substring(with: posicao1..<posicao2)) == 9 }
        
        return false
    }
}
