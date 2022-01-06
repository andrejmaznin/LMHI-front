import SwiftUI

struct HomeView: View {
    let spacing: CGFloat = 20.0
    let color = Color("StarkWhite")
    let height: CGFloat = 120.0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: spacing) {
                    NavigationButton(destination: TestsMenuView(), backgroundColor: color, height: height) {
                        Text("Тест")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: MeditationView(), backgroundColor: color, height: height) {
                        Text("Медитация")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: color, height: height) {
                        Text("Дневник насторения")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: color, height: height) {
                        Text("Привычки")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("LMHI")
                }
                
                ToolbarItem(placement:  .navigationBarTrailing) {
                    Button("Выйти") {
                        AppState.logOut()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
