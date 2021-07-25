import SwiftUI

struct ContentView: View {
    @State private var progress = 0
    
    private let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ProgressBar(
                title: "Meditation",
                currentMinutes: progress,
                goalMinutes: 30,
                foregroundColor: Color(
                    red: Util.normalizeColor(246),
                    green: Util.normalizeColor(207),
                    blue: Util.normalizeColor(69)
                ),
                backgroundColor: Color(
                    red: Util.normalizeColor(240),
                    green: Util.normalizeColor(222),
                    blue: Util.normalizeColor(175)
                )
            )
        }
        .onReceive(timer) { _ in
            if progress < 30 {
                progress += 1
            } else {
                progress = 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
