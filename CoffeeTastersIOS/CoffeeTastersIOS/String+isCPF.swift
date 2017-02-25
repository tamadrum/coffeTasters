import Foundation

extension String {

    func isCPF() -> Bool {
        let cpf = self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        
        if cpf.characters.count == 11 {
            let d1 = Int(cpf.substring(with: cpf.index(cpf.startIndex, offsetBy: 9)..<cpf.index(cpf.startIndex, offsetBy: 10)))
            let d2 = Int(cpf.substring(with: cpf.index(cpf.startIndex, offsetBy: 10)..<cpf.index(cpf.startIndex, offsetBy: 11)))
            
            var temp1 = 0, temp2 = 0
            
            for i in 0...8 {
                let char = Int(cpf.substring(with: cpf.index(cpf.startIndex, offsetBy: i)..<cpf.index(cpf.startIndex, offsetBy: i+1)))
                
                temp1 += char! * (10 - i)
                temp2 += char! * (11 - i)
            }
            
            temp1 %= 11
            temp1 = temp1 < 2 ? 0 : 11-temp1
            
            temp2 += temp1 * 2
            temp2 %= 11
            temp2 = temp2 < 2 ? 0 : 11-temp2
            
            if temp1 == d1 && temp2 == d2 {
                return true
            }
        }
        return false
    }
}
