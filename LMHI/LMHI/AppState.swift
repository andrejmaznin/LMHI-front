import SwiftUI

class AppState: ObservableObject {
    @Published var isLoading = true
    
    func start() {
        isLoading = false
    }
}
