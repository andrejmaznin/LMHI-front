import SwiftUI

class Form {
    static func validateEmail(email: String, emailPrompt: inout String) -> Bool {
        if email.isEmpty {
            emailPrompt = "Enter email address"
            return false
        }
        if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}", value: email) {
            emailPrompt = "Enter valid email address"
            return false
        }
        emailPrompt = ""
        return true
    }
}
