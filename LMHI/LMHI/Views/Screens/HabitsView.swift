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
                    
                    ForEach(0..<9) { id in
                        ProgressBar(title: VM.habits[id].name, goal: VM.habits[id].lower, upper: VM.habits[id].upper, value: VM.habits[id].value ?? "", current: $VM.values[id])
                            .padding(.horizontal)
                    }
                }
            }
            
            LoadingCover(isPresented: VM.loading)
        }
        .navigationBarBackButtonHidden(VM.loading)
        .navigationTitle("Привычки")
        .onDisappear {
            VM.save()
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
