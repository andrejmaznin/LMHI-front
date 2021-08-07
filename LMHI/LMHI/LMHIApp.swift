import SwiftUI

@main
struct LMHIApp: App {
    var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
