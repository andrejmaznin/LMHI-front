import SwiftUI

struct ContentView: View {
    @ObservedObject private var VM = ContentViewModel()
    
    @AppStorage("currentState") private var currentStateRawValue = ContentViewModel.State.start.rawValue
    
    private var currentState: ContentViewModel.State {
        ContentViewModel.State(rawValue: currentStateRawValue)!
    }
    
    var body: some View {
        Group {
            switch currentState {
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
