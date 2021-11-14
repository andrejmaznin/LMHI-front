import SwiftUI

struct TestResultsView: View {
    @AppStorage("testMainResult") private var result: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(R: 0, G: 73, B: 131))
                        .cornerRadius(30.0)
                        .aspectRatio(1.2, contentMode: .fit)
                        .padding()
                    
                    Text(result)
                }
                
                Rectangle()
                    .foregroundColor(Color(R: 29, G: 151, B: 114))
                    .cornerRadius(30.0)
                    .aspectRatio(1.2, contentMode: .fit)
                    .padding()
                Rectangle()
                    .foregroundColor(Color(R: 241, G: 47, B: 35))
                    .cornerRadius(30.0)
                    .aspectRatio(1.2, contentMode: .fit)
                    .padding()
                Rectangle()
                    .foregroundColor(Color(R: 242, G: 221, B: 0))
                    .cornerRadius(30.0)
                    .aspectRatio(1.2, contentMode: .fit)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Test Results")
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

struct TestResultsView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultsView()
    }
}
