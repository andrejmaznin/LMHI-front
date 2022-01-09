import SwiftUI

class TestViewModel: ObservableObject {
    enum Choice {
        case left
        case right
    }
    
    enum TestState {
        case initial
        case completed
        case resultsReceived
    }
    
    @Published var leftColor: Color
    @Published var rightColor: Color
    @Published var testState = TestState.initial
    @Published var showLoadingCover = false
    @Published var showAlert = false
    @Published var results: [String?] = []
    
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
        switch choice {
        case .left:
            currentState[currentShade][sequence[currentChoice].0] += 1
        case .right:
            currentState[currentShade][sequence[currentChoice].1] += 1
        }
        AppState.debugLog(currentState)
        
        currentChoice += 1
        if currentChoice > 5 {
            currentChoice = 0
            currentShade += 1
        }
        if currentShade > 4 {
            currentChoice = 0
            currentShade = 0
            testState = .completed
            showLoadingCover = true
            getResultID()
        }
        
        leftColor = colors[currentShade][sequence[currentChoice].0]
        rightColor = colors[currentShade][sequence[currentChoice].1]
    }
    
    func parseResults(_ state: [[Int]]) -> TestResultsModel {
        var result = [0, 0, 0, 0, 0]
        for i in (0...4) {
            for j in (0...3) {
                result[i] *= 10
                result[i] += state[i][j]
            }
        }
        
        return TestResultsModel(result)
    }
    
    func getResultID() {
        let testResultsModel = parseResults(currentState)
        
        AppState.debugLog("Test completed")
        AppState.debugLog(testResultsModel)
        
        APIService.submitTestResults(model: testResultsModel, token: AppState.load(key: "token", defaultValue: "")) { [unowned self] result in
            AppState.debugLog(result)
            self.showLoadingCover = false
            switch result {
            case .success(let id):
                print(id)
                getInterpretation(id)
//                    if result.blue == "ERROR" && result.green == "ERROR" && result.red == "ERROR" && result.yellow == "ERROR" {
//                        AppState.setState(.home)
//                    } else {
//                        results = [result.main, result.blue, result.green, result.red, result.yellow]
//                        testState = .resultsReceived
//                    }
            case .failure:
                self.showAlert = true
            }
        }
    }
    
    func getInterpretation(_ id: Int) {
        let model = TestResultInterpretationModel(id)
        APIService.getTestResultInterpretation(model: model) { result in
            switch result {
            case .success(let result):
                self.results = [result.main, result.blue, result.green, result.red, result.yellow]
                self.testState = .resultsReceived
            case .failure(let error):
                print(error)
            }
        }
    }
}
