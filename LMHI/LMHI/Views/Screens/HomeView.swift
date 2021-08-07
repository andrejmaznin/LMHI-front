import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            Text("Logged in")
                .navigationBarTitle("LMHI")
                .navigationBarItems(trailing: Button("Log Out") {
                    appState.isAuthenticated = .signedOut
                })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
