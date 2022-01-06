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
    
    static func load<Data>(key: String, defaultValue: Data) -> Data {
        return storage.object(forKey: key) as? Data ?? defaultValue
    }
    
    static func setState(_ state: ContentViewModel.State) {
        store(key: "currentState", value: state.rawValue)
    }
    
    static func logOut() {
        AppState.debugLog("Exit Success")
        AppState.store(key: "token", value: "")
        AppState.store(key: "email", value: "")
        AppState.store(key: "hashedPassword", value: "")
        AppState.setState(.start)
    }
}
