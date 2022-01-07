import Foundation

class TestsMenuViewModel: ObservableObject {
    @Published var loading: Bool
    @Published var showAlert: Bool
    
    init() {
        self.loading = true
        self.showAlert = false
        let model = AllTestsResultsModel(AppState.load(key: "token", defaultValue: ""))
        APIService.getAllTestResults(model: model) { [unowned self] result in
            AppState.debugLog(result)
            self.loading = false
            switch result {
            case .success(let result):
                print("Recieved")
            case .failure:
                self.showAlert = true
            }
        }
    }
}
