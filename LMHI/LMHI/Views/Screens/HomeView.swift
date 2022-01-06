import SwiftUI

struct HomeView: View {
    @ObservedObject private var VM = HomeViewModel()
    
    let aspectRatio: CGFloat = 3.15
    
    var body: some View {
        NavigationView {
            ZStack {
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
                    .padding()
                    
                    MoodDiary(moodCriterias: VM.moodCriterias)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: Color("GovernorBay"), height: 120.0) {
                        Text("Экран с привычками")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    .padding()
                }
                
                LoadingCover(isPresented: VM.showLoadingCover)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("LMHI")
                }
                
                ToolbarItem(placement:  .navigationBarTrailing) {
                    Button("Log Out") {
                        AppState.logOut()
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
