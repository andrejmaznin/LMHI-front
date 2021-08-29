import SwiftUI

struct TestView: View {
    @ObservedObject var VM = TestViewModel()
    
    var body: some View {
        NavigationView {
            HStack {
                Rectangle()
                    .foregroundColor(VM.leftColor)
                    .cornerRadius(30.0)
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .aspectRatio(0.6, contentMode: .fit)
                    .onTapGesture {
                        VM.process(.left)
                    }
                
                Spacer()
                    .frame(width: 30)
                
                Rectangle()
                    .foregroundColor(VM.rightColor)
                    .cornerRadius(30.0)
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .aspectRatio(0.6, contentMode: .fit)
                    .onTapGesture {
                        VM.process(.right)
                    }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Test")
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

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
