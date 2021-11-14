import SwiftUI

class ContentViewModel: ObservableObject {
    enum State: Int {
        case start
        case test
        case testResults
        case home
    }
    
    @AppStorage("currentState") private var currentStateRawValue = State.start.rawValue
    
    func getState() -> State {
        return State(rawValue: currentStateRawValue)!
    }
}
