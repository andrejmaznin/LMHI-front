import SwiftUI

class AppState {
    static var isInDebugMode: Bool = false
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
    
    static func logOut() {
        let signOutModel = SignOutModel(login: UserDefaults.standard.string(forKey: "email")!, id: UserDefaults.standard.integer(forKey: "sessionID"))
        APIService.exit(model: signOutModel) { result in
            print(result)
            switch result {
            case .success:
                print("Exit Success")
                UserDefaults.standard.set(0, forKey: "sessionID")
                UserDefaults.standard.set("", forKey: "email")
                UserDefaults.standard.set("", forKey: "hashedPassword")
                UserDefaults.standard.set(ContentViewModel.State.start.rawValue, forKey: "currentState")
            case .failure:
                print("Exit Failure")
            }
        }
    }
}
