import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var showLoading = false
    @Published var showAlert = false
    
    var emailPrompt = ""
    var passwordPrompt = ""
    
    func signIn() {
        showLoading = true
        let signInModel = SignInModel(login: email, hashed_password: Util.hash(password))
        APIService.authenticate(model: signInModel) { result in
            print(result)
            self.clearPrompts()
            self.showLoading = false
            switch result {
            case .success(let id):
                print("SignIn Success")
                self.clearFields()
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
    
    func clearFields() {
        email = ""
        password = ""
    }
    
    func clearPrompts() {
        emailPrompt = ""
        passwordPrompt = ""
    }
}
