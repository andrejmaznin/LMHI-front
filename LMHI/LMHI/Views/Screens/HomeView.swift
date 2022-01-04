import SwiftUI

struct HomeView: View {
    @ObservedObject private var VM = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationButton(destination: HabitsView(), backgroundColor: Color("GovernorBay"), height: 120.0) {
                        Text("Тест")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: Color("GovernorBay"), height: 120.0) {
                        Text("Медитация")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                }
                
//                ForEach(0..<VM.moodCriterias.count, id: \.self) { id in
                    Picker(title: "Мотивация", currentSelection: $VM.tempSelect)
//                }
                
                NavigationButton(destination: HabitsView(), backgroundColor: Color("GovernorBay"), height: 120.0) {
                    Text("Экран с привычками")
                        .foregroundColor(.white)
                        .font(Fonts.label)
                }
            }
            .padding()
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
                                AppState.store(key: "sessionID", value: 0)
                                AppState.store(key: "email", value: "")
                                AppState.store(key: "hashedPassword", value: "")
                                AppState.store(key: "hashedPassword", value: "")
                                AppState.setState(.start)
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
