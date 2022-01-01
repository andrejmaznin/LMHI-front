import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var selections: [Int]
    @Published var moodCriterias: [String]
    @Published var showLoadingCover: Bool
    
    init() {
        self.showLoadingCover = true
        self.selections = []
        self.moodCriterias = []
        APIService.getMoodCriterias() { [unowned self] result in
            self.showLoadingCover = false
            switch result {
            case .success(let criterias):
                AppState.debugLog("Success")
                self.moodCriterias = criterias
                print(moodCriterias)
                for _ in 0..<self.moodCriterias.count {
                    self.selections.append(0)
                }
                print(selections)
            case .failure:
                print("Error")
            }
        }
    }
}
