import SwiftUI

struct ContentView: View {
    @ObservedObject private var VM = ContentViewModel()
    
    var body: some View {
        Group {
            switch VM.getState() {
            case .start:
                StartView()
            case .test:
                TestView()
            case .testResults:
                TestResultsView()
            case .home:
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
