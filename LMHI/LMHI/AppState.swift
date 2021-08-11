import Foundation

class AppState: ObservableObject {
    @Published var isLoading = true
    @Published var isAuthenticated = false
    
    func start() {
        isLoading = false
    }
}
