import SwiftUI

class ContentViewModel: ObservableObject {
    enum State: Int {
        case start
        case test
        case testResults
        case home
    }
}
