import SwiftUI

class TestViewModel: ObservableObject {
    enum Choice {
        case left
        case right
    }
    
    @Published var leftColor: Color
    @Published var rightColor: Color
    
    let colors = [
        [Color("DarkestBlue"), Color("BluishGreen"), Color("Red"), Color("Yellow")],
        [Color("DarkestBlue"), Color("GreenishBlue"), Color("DarkBlue"), Color("Blue")],
        [Color("DarkestGreen"), Color("BluishGreen"), Color("Green"), Color("LightGreen")],
        [Color("DarkRed"), Color("OrangeRed"), Color("Red"), Color("DarkestRed")],
        [Color("DarkOrangeYellow"), Color("YellowGreen"), Color("OrangeYellow"), Color("Yellow")]
    ]
    
    let sequence = [
        [(0, 3), (1, 2), (0, 1), (2, 3), (0, 2), (1, 3)],
        [(0, 3), (1, 2), (0, 1), (2, 3), (0, 2), (1, 3)],
        [(0, 3), (1, 2), (0, 1), (2, 3), (0, 2), (1, 3)],
        [(0, 3), (1, 2), (0, 1), (2, 3), (0, 2), (1, 3)],
        [(0, 3), (1, 2), (0, 1), (2, 3), (0, 2), (1, 3)]
    ]
    
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
        leftColor = colors[currentShade][sequence[currentShade][currentChoice].0]
        rightColor = colors[currentShade][sequence[currentShade][currentChoice].1]
    }
    
    func process(_ choice: Choice) {
        print(choice)
        switch choice {
        case .left:
            currentState[currentShade][sequence[currentShade][currentChoice].0] += 1
        case .right:
            currentState[currentShade][sequence[currentShade][currentChoice].1] += 1
        }
        
        currentChoice += 1
        if currentChoice > 5 {
            currentChoice = 0
            currentShade += 1
        }
        if currentShade > 4 {
            currentChoice = 0
            currentShade = 0
            
            print("Test completed")
            print(parseResults(currentState))
            
            let testResultsModel = TestResultsModel(results: parseResults(currentState))
            APIService.submitTestResults(model: testResultsModel) { result in
                print(result)
                switch result {
                case .success:
                    print("Test Success")
                    UserDefaults.standard.set(ContentViewModel.State.testResults.rawValue, forKey: "currentState")
                case .failure:
                    print("Test Failure")
                }
            }
        }
        
        leftColor = colors[currentShade][sequence[currentShade][currentChoice].0]
        rightColor = colors[currentShade][sequence[currentShade][currentChoice].1]
    }
    
    func parseResults(_ state: [[Int]]) -> [String] {
        var result = ["main", "blue", "green", "red", "yellow"]
        for i in (0...4) {
            for j in (0...3) {
                result[i] += String(state[i][j])
            }
        }
        
        return result
    }
}
