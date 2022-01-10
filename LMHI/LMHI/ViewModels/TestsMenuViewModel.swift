import Foundation

class TestsMenuViewModel: ObservableObject {
    @Published var loading: Bool
    @Published var showAlert: Bool
    @Published var dates: [String]
    
    private var IDs: [Int]
    
    init() {
        self.loading = true
        self.showAlert = false
        self.IDs = []
        self.dates = []
        let model = AllTestsResultsModel(AppState.load(key: "token", defaultValue: ""))
        APIService.getAllTestResults(model: model) { [unowned self] result in
            AppState.debugLog(result)
            self.loading = false
            switch result {
            case .success(let results):
                for result in results {
                    IDs.append(result.id)
                    let date = Date(timeIntervalSince1970: Double(result.date))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd.MM.YYYY hh:mm"
                    dateFormatter.timeZone = .current
                    dates.append(dateFormatter.string(from: date))
                }
            case .failure:
                self.showAlert = true
            }
        }
    }
}
