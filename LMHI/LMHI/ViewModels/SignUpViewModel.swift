import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var personName = ""
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var termsAndConditions = false
    
    @Published var personNamePrompt = ""
    @Published var emailPrompt = ""
    @Published var usernamePrompt = ""
    @Published var passwordPrompt = ""
    
    var validFieldsCounter = 0
    
    func signUp() {
        print("Sign up")
    }
    
    //validation
    func validatePersonName() {
        if personName.isEmpty {
            personNamePrompt = "Enter your name"
            return
        }
        if !Util.evaluateRegEx(regEx: "[A-Za-z'-]+", value: personName) || personName.count < 3 || personName.count > 32 {
            personNamePrompt = "Enter valid name"
            return
        }
        personNamePrompt = ""
        validFieldsCounter += 1
    }
    
    func validateEmail() {
        if email.isEmpty {
            emailPrompt = "Enter email address"
            return
        }
        if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}", value: email) {
            emailPrompt = "Enter valid email address"
            return
        }
        emailPrompt = ""
        validFieldsCounter += 1
    }
    
    func validateUsername() {
        if username.isEmpty {
            usernamePrompt = "Enter username"
            return
        }
        if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z_]+", value: username) {
            usernamePrompt = "Username must contain only letters, numbers or underscores"
            return
        }
        if !Util.evaluateRegEx(regEx: "[0-9]*[A-Za-z][A-Z0-9a-z_]*", value: username) {
            usernamePrompt = "Username must contain at least one letter"
            return
        }
        if username.count < 4 {
            usernamePrompt = "Username is too short"
            return
        }
        if username.count > 30 {
            usernamePrompt = "Username is too long"
            return
        }
        usernamePrompt = ""
        validFieldsCounter += 1
    }
    
    func validatePassword() {
        if password.isEmpty {
            passwordPrompt = "Enter password"
            return
        }
        if password.count < 8 {
            passwordPrompt = "Password must contain at least 8 characters"
            return
        }
        if password.count > 32 {
            passwordPrompt = "Password is too long"
            return
        }
        passwordPrompt = ""
        validFieldsCounter += 1
    }
    
    var isFormValid: Bool {
        return (validFieldsCounter == 4) && termsAndConditions
    }
}
