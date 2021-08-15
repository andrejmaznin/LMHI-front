import SwiftUI

class AppState: ObservableObject {
    @AppStorage("isAuthenticated") var isAuthenticated = false
    @AppStorage("email") var email = ""
    @AppStorage("hashedPassword") var hashedPassword = ""
    
    @Published var isLoading = true
    
    func start() {
        isLoading = false
    }
}
