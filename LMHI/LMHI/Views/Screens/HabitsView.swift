import SwiftUI

struct HabitsView: View {
    @ObservedObject var VM = HabitsViewModel()
    
    var body: some View {
        Group {
            if VM.loading {
                LoadingCover()
                    .navigationBarBackButtonHidden(true)
            } else {
                ScrollView {
                    VStack {
                        Text("Track your habits")
                            .font(Fonts.title)
                        
                        
                    }
                }
            }
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
