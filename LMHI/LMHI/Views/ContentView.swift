import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    @AppStorage("isAuthenticated") var isAuthenticated = false
    
    var body: some View {
        Group {
            if appState.isLoading {
                LoadingView()
            } else if isAuthenticated {
                HomeView()
            } else {
                StartView()
            }
        }
        .onAppear {
            appState.start()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
