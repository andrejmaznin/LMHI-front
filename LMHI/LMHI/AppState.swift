import Foundation

class AppState: ObservableObject {
    enum APIAuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isAuthenticated: APIAuthState = .undefined
    
    func configureAPIStateChangeListener() {
        isAuthenticated = .signedOut
    }
}
