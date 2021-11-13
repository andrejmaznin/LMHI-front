import SwiftUI

class SignInViewModel: ObservableObject {
    @EnvironmentObject var appModel: AppModel
    
    @Published var email = ""
    @Published var password = ""
    @Published var emailPrompt = ""
    @Published var passwordPrompt = ""
    @Published var isFormCorrect = false
    @Published var showLoadingCover = false
    @Published var showAlert = false
    
    func validateEmail(email: String) {
        emailPrompt = Form.validateEmail(email: email)
        isFormCorrect = isFormCorrect && emailPrompt.isEmpty
    }
    
    func validatePassword(password: String) {
        passwordPrompt = Form.validatePassword(password: password)
        isFormCorrect = isFormCorrect && passwordPrompt.isEmpty
    }
    
    func signIn() {
        showLoadingCover = true
        let signInModel = SignInModel(login: email, hashed_password: Util.hash(password))
        APIService.authenticate(model: signInModel) { result in
            print(result)
            self.clearPrompts()
            self.showLoadingCover = false
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
