import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var emailPrompt = ""
    @Published var passwordPrompt = ""
    @Published var showLoadingCover = false
    @Published var showAlert = false
    
    func validateEmail(email: String) {
        emailPrompt = Form.validateEmail(email: email)
    }
    
    func validatePassword(password: String) {
        if password.isEmpty {
            passwordPrompt = "Enter password"
        } else {
            passwordPrompt = ""
        }
    }
    
    func validateForm() -> Bool {
        if AppState.isInDebugMode {
            return true
        }
        
        return !email.isEmpty && emailPrompt.isEmpty && !password.isEmpty && passwordPrompt.isEmpty
    }
    
    func signIn() {
        showLoadingCover = true
        let signInModel = SignInModel(login: email, hashed_password: Util.hash(password))
        APIService.authenticate(model: signInModel) { result in
            AppState.debugLog(result)
            self.showLoadingCover = false
            switch result {
            case .success(let id):
                AppState.debugLog("SignIn Success")
                self.email = ""
                self.password = ""
                UserDefaults.standard.set(id, forKey: "sessionID")
                UserDefaults.standard.set(signInModel.login, forKey: "email")
                UserDefaults.standard.set(signInModel.hashed_password, forKey: "hashedPassword")
                UserDefaults.standard.set(ContentViewModel.State.home.rawValue, forKey: "currentState")
            case .failure(let error):
                switch error {
                case .wrongEmail:
                    self.emailPrompt = "Wrong email"
                case .wrongPassword:
                    self.passwordPrompt = "Wrong password"
                default:
                    self.showAlert = true
                }
            }
        }
    }
}
