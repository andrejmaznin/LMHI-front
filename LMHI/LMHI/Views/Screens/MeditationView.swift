import SwiftUI
import AVKit

struct MeditationView: View {
    //couldn't put player's code in VM because in SwiftUI you can't access @State variables outside of body, that's awful but there is no other way.
    @ObservedObject var VM: MeditationViewModel
    
    @State private var player: AVAudioPlayer!
    @State private var currentTrack: Int
    
    private var tracks = ["meditation_cloudy", "meditation_a_new_leaf", "meditation_sky", "meditation_water"]
    
    init() {
        VM = MeditationViewModel()
        self.player = AVAudioPlayer()
        self.currentTrack = Int.random(in: 0..<tracks.count)
    }
    
    var body: some View {
        VStack {
            Text("Время медитации:")
                .font(Fonts.bold)
                .padding(.vertical)
            
            Text(String(format: "%02d:%02d", VM.minutes, VM.seconds))
                .font(Fonts.time)
            
            ActionButton(action: {
                if VM.stopwatchMode == .initial {
                    player.play()
                    AppState.debugLog("Playing \(tracks[currentTrack])")
                    VM.start()
                } else {
                    if player.isPlaying {
                        player.stop()
                        AppState.debugLog("Stopped \(tracks[currentTrack])")
                    }
                    AppState.debugLog(player.currentTime)
                    VM.stop()
                }
            }, backgroundColor: VM.stopwatchMode == .initial ? .green : .red) {
                Text(VM.stopwatchMode == .initial ? "Начать" : "Закончить")
                    .font(Fonts.label)
                    .foregroundColor(.white)
            }
            .opacity(VM.stopwatchMode == .finished ? 0.0 : 1.0)
        }
        .padding()
        .navigationBarBackButtonHidden(VM.stopwatchMode == .running)
        .navigationTitle("Медитация")
        .onAppear {
            if let path = Bundle.main.path(forResource: tracks[currentTrack], ofType: "mp3") {
                player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player.prepareToPlay()
                AppState.debugLog("Successfully loaded track \(tracks[currentTrack])")
            } else {
                fatalError("Couldn't load file \(tracks[currentTrack])!")
            }
        }
        .onDisappear {
            player = AVAudioPlayer()
            currentTrack = Int.random(in: 0..<tracks.count)
            VM.reset()
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
