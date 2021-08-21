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
        let signInModel = SignInModel(login: email, action: "login", hashed_password: Util.hash(password))
        APIService.authenticate(model: signInModel) { result in
            print(result)
            self.clearFields()
            self.showLoading = false
            switch result {
            case .success:
                print("SignIn Success")
                UserDefaults.standard.set(signInModel.login, forKey: "email")
                UserDefaults.standard.set(signInModel.hashed_password, forKey: "hashedPassword")
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
            case .failure(let error):
                if error == .wrongData {
                    self.emailPrompt = "Wrong email or password"
                } else {
                    self.showAlert = true
                }
            }
        }
    }
    
    func clearFields() {
        email = ""
        password = ""
        
        emailPrompt = ""
        passwordPrompt = ""
    }
}
