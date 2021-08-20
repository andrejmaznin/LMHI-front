import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Logged in as \(UserDefaults.standard.string(forKey: "personName")!)")
                Text(UserDefaults.standard.string(forKey: "email")!)
            }
            .navigationBarHidden(true)
//            .navigationBarItems(trailing: Button("Log Out") {
//                UserDefaults.standard.set("", forKey: "email")
//                UserDefaults.standard.set("", forKey: "hashedPassword")
//                UserDefaults.standard.set(false, forKey: "isAuthenticated")
//            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
