import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var personName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var termsAndConditions = false
    
    @Published var showLoading = false
    @Published var showAlert = false
    
    var personNamePrompt = ""
    var emailPrompt = ""
    var passwordPrompt = ""
    
    func signUp() {
        showLoading = true
        let signUpModel = SignUpModel(name: personName, hashed_password: Util.hash(password), email: email, info: "")
        APIService.createUser(model: signUpModel) { [unowned self] result in
            print(result)
            clearFields()
            self.showLoading = false
            switch result {
            case .success:
                let signInModel = SignInModel(login: signUpModel.email, action: "login", hashed_password: signUpModel.hashed_password)
                APIService.authenticate(model: signInModel) { result in
                    print(result)
                    switch result {
                    case .success:
                        print("SignUp Success")
                        UserDefaults.standard.set(signUpModel.name, forKey: "personName")
                        UserDefaults.standard.set(signInModel.login, forKey: "email")
                        UserDefaults.standard.set(signInModel.hashed_password, forKey: "hashedPassword")
                        UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    case .failure:
                        self.showAlert = true
                    }
                }
            case .failure(let error):
                if error == .userAlreadyExists {
                    self.emailPrompt = "Email already registered"
                } else {
                    self.showAlert = true
                }
            }
        }
    }
    
    func clearFields() {
        personName = ""
        email = ""
        password = ""
        termsAndConditions = false
        
        personNamePrompt = ""
        emailPrompt = ""
        passwordPrompt = ""
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
        validatePersonName() && validateEmail() && validatePassword() && termsAndConditions
    }
}
