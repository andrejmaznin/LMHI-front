import SwiftUI

struct MeditationView: View {
    @ObservedObject var VM = MeditationViewModel()
    
    var body: some View {
        VStack {
            Text("Время медитации:")
                .font(Fonts.bold)
                .padding(.vertical)
            
            Text(String(format: "%02d:%02d", VM.minutes, VM.seconds))
                .font(Fonts.time)
            
            ActionButton(action: VM.process, backgroundColor: VM.stopwatchMode == .initial ? .green : .red) {
                Text(VM.stopwatchMode == .initial ? "Начать" : "Закончить")
                    .font(Fonts.label)
                    .foregroundColor(.white)
            }
            .opacity(VM.stopwatchMode == .finished ? 0.0 : 1.0)
        }
        .padding()
        .navigationBarBackButtonHidden(VM.stopwatchMode == .running)
        .navigationTitle("Медитация")
        .onDisappear {
            VM.reset()
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
