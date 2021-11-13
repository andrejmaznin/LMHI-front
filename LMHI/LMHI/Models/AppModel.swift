import SwiftUI

class AppModel: ObservableObject {
    @Published var isInDebugMode: Bool
    
    init() {
        isInDebugMode = true
    }
}
