import SwiftUI

class AppState {
    static var isInDebugMode: Bool = true
    static private var storage = UserDefaults.standard
    
    static func debugLog<Data>(_ data: Data) {
        if isInDebugMode {
            print(data)
        }
    }
    
    static func store<Data>(key: String, value: Data) {
        storage.set(value, forKey: key)
    }
}
