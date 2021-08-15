import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var personName = ""
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var termsAndConditions = false
    
    var personNamePrompt = ""
    var emailPrompt = ""
    var usernamePrompt = ""
    var passwordPrompt = ""
    
    @Published var showProgress = false
    @Published var showAlert = false
    
    var validFieldsCounter = 0
    
    func signUp() {
        showProgress = true
        
        emailPrompt = ""
        
        let signUpModel = SignUpModel(name: personName, hashed_password: Util.hash(password), email: email, info: "")
        APIService.createUser(model: signUpModel) { [unowned self] result in
            print(result)
            switch result {
            case .success:
                let signInModel = SignInModel(login: signUpModel.email, action: "login", hashed_password: signUpModel.hashed_password)
                APIService.authenticate(model: signInModel) { [unowned self] result in
                    print(result)
                    self.showProgress = false
                    switch result {
                    case .success:
                        print("SignUp Success")
                    case .failure:
                        self.showAlert = true
                    }
                }
            case .failure(let error):
                self.showProgress = false
                if error == APIService.APIError.userAlreadyExists {
                    self.emailPrompt = "Email already registered"
                } else {
                    self.showAlert = true
                }
            }
        }
    }
    
    //validation
    func validatePersonName() -> Bool {
        if personName.isEmpty {
            personNamePrompt = "Enter your name"
            return false
        }
        if !Util.evaluateRegEx(regEx: "[A-Za-z'-]+", value: personName) || personName.count < 3 || personName.count > 32 {
            personNamePrompt = "Enter valid name"
            return false
        }
        personNamePrompt = ""
        return true
    }
    
    func validateEmail() -> Bool {
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
    
    func validateUsername() -> Bool {
        if username.isEmpty {
            usernamePrompt = "Enter username"
            return false
        }
        if !Util.evaluateRegEx(regEx: "[A-Z0-9a-z_]+", value: username) {
            usernamePrompt = "Username must contain only letters, numbers or underscores"
            return false
        }
        if !Util.evaluateRegEx(regEx: "[0-9]*[A-Za-z][A-Z0-9a-z_]*", value: username) {
            usernamePrompt = "Username must contain at least one letter"
            return false
        }
        if username.count < 4 {
            usernamePrompt = "Username is too short"
            return false
        }
        if username.count > 30 {
            usernamePrompt = "Username is too long"
            return false
        }
        usernamePrompt = ""
        return true
    }
    
    func validatePassword() -> Bool {
        if password.isEmpty {
            passwordPrompt = "Enter password"
            return false
        }
        if password.count < 8 {
            passwordPrompt = "Password must contain at least 8 characters"
            return false
        }
        if password.count > 32 {
            passwordPrompt = "Password is too long"
            return false
        }
        passwordPrompt = ""
        return true
    }
    
    var isFormValid: Bool {
        validatePersonName() && validateEmail() && validateUsername() && validatePassword() && termsAndConditions
    }
}
