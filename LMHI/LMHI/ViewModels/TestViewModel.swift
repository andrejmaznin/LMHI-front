import SwiftUI

class TestViewModel: ObservableObject {
    enum Choice {
        case left
        case right
    }
    
    @Published var leftColor: Color
    @Published var rightColor: Color
    @Published var showLoadingCover = false
    @Published var showAlert = false
    
    let colors = [
        [Color("DarkestBlue"), Color("BluishGreen"), Color("Red"), Color("Yellow")],
        [Color("DarkestBlue"), Color("GreenishBlue"), Color("DarkBlue"), Color("Blue")],
        [Color("DarkestGreen"), Color("BluishGreen"), Color("Green"), Color("LightGreen")],
        [Color("DarkRed"), Color("OrangeRed"), Color("Red"), Color("DarkestRed")],
        [Color("DarkOrangeYellow"), Color("GreenYellow"), Color("OrangeYellow"), Color("Yellow")]
    ]
    let sequence = [(0, 3), (1, 2), (0, 1), (2, 3), (0, 2), (1, 3)]
    
    var currentShade = 0
    var currentChoice = 0
    var currentState = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
    ]
    
    init() {
        leftColor = colors[currentShade][sequence[currentChoice].0]
        rightColor = colors[currentShade][sequence[currentChoice].1]
    }
    
    func process(_ choice: Choice) {
        AppState.debugLog(choice)
        switch choice {
        case .left:
            currentState[currentShade][sequence[currentChoice].0] += 1
        case .right:
            currentState[currentShade][sequence[currentChoice].1] += 1
        }
        
        currentChoice += 1
        if currentChoice > 5 {
            currentChoice = 0
            currentShade += 1
        }
        if currentShade > 4 {
            currentChoice = 0
            currentShade = 0
            
            AppState.debugLog("Test completed")
            AppState.debugLog(parseResults(currentState))
            
            showLoadingCover = true
            let testResultsModel = parseResults(currentState)
            APIService.submitTestResults(model: testResultsModel) { [unowned self] result in
                AppState.debugLog(result)
                self.showLoadingCover = false
                switch result {
                case .success(let results):
                    AppState.store(key: "testMainResult", value: results[0])
                    AppState.store(key: "testBlueResult", value: results[1])
                    AppState.store(key: "testGreenResult", value: results[2])
                    AppState.store(key: "testRedResult", value: results[3])
                    AppState.store(key: "testYellowResult", value: results[4])
                    AppState.store(key: "currentState", value: ContentViewModel.State.testResults.rawValue)
                case .failure:
                    self.showAlert = true
                }
            }
        }
        
        leftColor = colors[currentShade][sequence[currentChoice].0]
        rightColor = colors[currentShade][sequence[currentChoice].1]
    }
    
    func parseResults(_ state: [[Int]]) -> TestResultsModel {
        var result = ["", "", "", "", ""]
        for i in (0...4) {
            for j in (0...3) {
                result[i] += String(state[i][j])
            }
        }
        
        return TestResultsModel(main: result[0], blue: result[1], green: result[2], red: result[3], yellow: result[4])
    }
}
