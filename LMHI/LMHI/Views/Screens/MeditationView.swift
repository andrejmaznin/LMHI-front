import SwiftUI

struct MeditationView: View {
    var body: some View {
        VStack {
            
            
            ActionButton(action: {}, backgroundColor: .green) {
                Text("Начать")
                    .font(Fonts.label)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .navigationTitle("Медитация")
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
