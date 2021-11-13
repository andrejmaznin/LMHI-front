import SwiftUI

class AppState {
    static var isInDebugMode: Bool = false
    
    static func debugLog<Data>(_ data: Data) {
        if isInDebugMode {
            print(data)
        }
    }
}
