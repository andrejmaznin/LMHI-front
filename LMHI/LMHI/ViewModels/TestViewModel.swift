import SwiftUI

class TestViewModel: ObservableObject {
    enum Choice {
        case left
        case right
    }
    
    @Published var leftColor: Color
    @Published var rightColor: Color
    
    let colors = [
        [Color(R: 0, G: 73, B: 131), Color(R: 29, G: 151, B: 114), Color(R: 241, G: 47, B: 35), Color(R: 242, G: 221, B: 0)],
        [Color(R: 0, G: 73, B: 131), Color(R: 43, G: 115, B: 129), Color(R: 71, G: 93, B: 143), Color(R: 85, G: 169, B: 206)],
        [Color(R: 90, G: 119, B: 61), Color(R: 29, G: 151, B: 114), Color(R: 65, G: 168, B: 95), Color(R: 150, G: 203, B: 89)],
        [Color(R: 192, G: 82, B: 35), Color(R: 250, G: 128, B: 42), Color(R: 241, G: 47, B: 35), Color(R: 179, G: 62, B: 44)],
        [Color(R: 228, G: 147, B: 72), Color(R: 191, G: 212, B: 73), Color(R: 250, G: 149, B: 61), Color(R: 242, G: 221, B: 0)]
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
    var currentState = [0, 0, 0, 0]
    
    init() {
        leftColor = colors[currentShade][sequence[currentShade][currentChoice].0]
        rightColor = colors[currentShade][sequence[currentShade][currentChoice].1]
    }
    
    func process(_ choice: Choice) {
        print(choice)
        switch choice {
        case .left:
            currentState[sequence[currentShade][currentChoice].0] += 1
        case .right:
            currentState[sequence[currentShade][currentChoice].1] += 1
        }
        
        currentChoice += 1
        if currentChoice > 5 {
            currentChoice = 0
            currentShade += 1
            print(currentState)
            currentState = [0, 0, 0, 0]
        }
        if currentShade > 4 {
            print("Test completed")
            currentChoice = 0
            currentShade = 0
        }
        
        leftColor = colors[currentShade][sequence[currentShade][currentChoice].0]
        rightColor = colors[currentShade][sequence[currentShade][currentChoice].1]
    }
}
