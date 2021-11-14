import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var fullNamePrompt = ""
    @Published var emailPrompt = ""
    @Published var passwordPrompt = ""
    @Published var termsAndConditions = false
    @Published var showLoadingCover = false
    @Published var showAlert = false
    
    func validateFullName(fullName: String) {
        fullNamePrompt = Form.validateFullName(fullName)
    }
    
    func validateEmail(email: String) {
        emailPrompt = Form.validateEmail(email)
    }
    
    func validatePassword(password: String) {
        passwordPrompt = Form.validatePassword(password)
    }
    
    func validateForm() -> Bool {
        if AppState.isInDebugMode {
            return true
        }
        
        return !fullName.isEmpty && fullNamePrompt.isEmpty && !email.isEmpty && emailPrompt.isEmpty && !password.isEmpty && passwordPrompt.isEmpty && termsAndConditions
    }
    
    func signUp() {
        showLoadingCover = true
        let signUpModel = SignUpModel(name: fullName, hashed_password: Util.hash(password), email: email, info: "")
        APIService.createUser(model: signUpModel) { [unowned self] result in
            AppState.debugLog(result)
            self.showLoadingCover = false
            switch result {
            case .success:
                let signInModel = SignInModel(login: signUpModel.email, hashed_password: signUpModel.hashed_password)
                APIService.authenticate(model: signInModel) { [unowned self] result in
                    AppState.debugLog(result)
                    switch result {
                    case .success(let id):
                        AppState.debugLog("SignUp Success")
                        self.fullName = ""
                        self.email = ""
                        self.password = ""
                        self.termsAndConditions = false
                        AppState.store(key: "sessionID", value: id)
                        AppState.store(key: "email", value: signInModel.login)
                        AppState.store(key: "hashedPassword", value: signInModel.hashed_password)
                        AppState.store(key: "currentState", value: ContentViewModel.State.home.rawValue)
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
}
