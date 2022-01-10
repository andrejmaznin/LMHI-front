import SwiftUI

struct MoodDiaryView: View {
    @ObservedObject var VM = MoodDiaryViewModel()
    
    let spacing: CGFloat = 20.0
    let aspectRatio: CGFloat = 3.15
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: spacing) {
                    ForEach(0..<VM.moodCriterias.count, id: \.self) { id in
                        Picker(title: VM.moodCriterias[id].replacingOccurrences(of: "'", with: "\""), currentSelection: $VM.selections[id])
                            .padding(.horizontal)
                    }
                }
            }
            
            LoadingCover(isPresented: VM.loading)
        }
        .navigationBarBackButtonHidden(VM.loading)
        .navigationTitle("Дневник настроения")
    }
}

struct MoodDiaryView_Previews: PreviewProvider {
    static var previews: some View {
        MoodDiaryView()
    }
}
