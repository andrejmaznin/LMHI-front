import Foundation

class TestsMenuViewModel: ObservableObject {
    @Published var loading: Bool
    @Published var showAlert: Bool
    @Published var dates: [String]
    @Published var results: [[String?]]
    
    init() {
        self.loading = true
        self.showAlert = false
        self.dates = []
        self.results = []
        let model = AllTestsResultsModel(AppState.load(key: "token", defaultValue: ""))
        APIService.getAllTestResults(model: model) { [unowned self] result in
            AppState.debugLog(result)
            self.loading = false
            switch result {
            case .success(let results):
                for result in results {
                    let model = TestResultInterpretationModel(result.id)
                    APIService.getTestResultInterpretation(model: model) { result in
                        switch result {
                        case .success(let result):
                            self.results.append([result.main, result.blue, result.green, result.red, result.yellow])
                        case .failure(let error):
                            print(error)
                        }
                    }
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
