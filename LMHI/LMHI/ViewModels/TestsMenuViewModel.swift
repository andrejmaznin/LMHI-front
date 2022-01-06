import Foundation

class TestsMenuViewModel: ObservableObject {
    @Published var loading: Bool
    
    init() {
        self.loading = true
        self.loading = false
    }
}
