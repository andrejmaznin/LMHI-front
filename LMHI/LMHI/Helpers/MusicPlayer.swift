import SwiftUI
import AVKit

struct MusicPlayer: View {
    private let tracks: [String]
    
    @State private var player: AVAudioPlayer!
    @State private var currentTrack: Int
    
    init(_ tracks: [String]) {
        self.player = AVAudioPlayer()
        self.tracks = tracks
        self.currentTrack = Int.random(in: 0..<tracks.count)
    }
    
    var body: some View {
        Text("Время медитации:")
            .font(Fonts.bold)
            .padding(.vertical)
            .onAppear {
                loadTrack()
            }
    }
    
    func loadTrack() {
        if let path = Bundle.main.path(forResource: tracks[currentTrack], ofType: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player.prepareToPlay()
                AppState.debugLog("Successfully loaded track \(tracks[currentTrack])")
            } catch {
                print(error)
                fatalError("Unable to play music!")
            }
        } else {
            fatalError("Couldn't load file \(tracks[currentTrack])!")
        }
    }
    
    func play() {
        player.play()
        AppState.debugLog("Playing \(tracks[currentTrack])")
    }
    
    func stop() {
        if player.isPlaying {
            player.stop()
            AppState.debugLog("Stopped \(tracks[currentTrack])")
        }
        AppState.debugLog(player.currentTime)
    }
}
