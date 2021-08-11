import Foundation
import CryptoKit

class Util {
    static func evaluateRegEx(regEx: String, value: String) -> Bool {
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return pred.evaluate(with: value)
    }
    
    static func hash(_ string: String) -> String {
        let inputData = string.data(using: .utf8)!
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashString
    }
}
