import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            switch appState.isAuthenticated {
            case .undefined:
                LoadingView()
            case .signedOut:
                StartView()
            case .signedIn:
                Text("Home View")
            }
        }
        .onAppear {
            appState.configureAPIStateChangeListener()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
