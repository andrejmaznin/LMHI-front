import SwiftUI

struct HomeView: View {
    @ObservedObject private var VM = HomeViewModel()
    
    let spacing: CGFloat = 20.0
    let color = Color("StarkWhite")
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: spacing) {
                    NavigationButton(destination: HabitsView(), backgroundColor: color, height: 120.0) {
                        Text("Тест")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: color, height: 120.0) {
                        Text("Медитация")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: color, height: 120.0) {
                        Text("MoodDiary")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    
                    NavigationButton(destination: HabitsView(), backgroundColor: color, height: 120.0) {
                        Text("Экран с привычками")
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
