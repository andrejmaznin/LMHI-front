import Foundation

class Util {
    static func arrayAndOperation(_ array: [Bool]) -> Bool {
        for value in array {
            if !value {
                return false
            }
        }
        
        return true
    }
    
    static func evaluateRegEx(regEx: String, value: String) -> Bool {
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: value)
    }
}
