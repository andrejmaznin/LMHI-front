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
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
