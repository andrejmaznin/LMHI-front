import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Logged in")
                Text(UserDefaults.standard.string(forKey: "email")!)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("LMHI")
                }
                
                ToolbarItem(placement:  .navigationBarTrailing) {
                    Button("Log Out") {
                        UserDefaults.standard.set("", forKey: "personName")
                        UserDefaults.standard.set("", forKey: "email")
                        UserDefaults.standard.set("", forKey: "hashedPassword")
                        UserDefaults.standard.set(false, forKey: "isAuthenticated")
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
