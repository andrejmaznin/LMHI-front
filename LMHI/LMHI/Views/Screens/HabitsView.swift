import SwiftUI

struct HabitsView: View {
    @ObservedObject var VM = HabitsViewModel()
    
    let spacing: CGFloat = 20.0
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: spacing) {
                    Text("Track your habits")
                        .font(Fonts.title)
                    
                    ForEach(VM.habits) { habit in
                        ProgressBar(title: habit.name, goal: habit.lower, upper: habit.upper, value: habit.value ?? "")
                            .padding(.horizontal)
                    }
                }
            }
            
            LoadingCover(isPresented: VM.loading)
        }
        .navigationBarBackButtonHidden(VM.loading)
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
