import SwiftUI

class Form {
    static func validateEmail(email: String) -> String {
        var result = ""
        if email.isEmpty {
            result = "Enter email address"
        }
        if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,8}", value: email) {
            result = "Enter valid email address"
        }
        
        return result
    }
    
    static func validatePassword(password: String) -> String {
        var result = ""
        if password.isEmpty {
            result = "Enter password"
        }
        if password.count < 8 {
            result = "Password must contain at least 8 characters"
        }
        if password.count > 32 {
            result = "Password is too long"
        }
        
        return result
    }
}
