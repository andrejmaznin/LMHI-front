import SwiftUI

struct ContentView: View {
    @ObservedObject var VM = ContentViewModel()
    
    @AppStorage("currentState") var currentStateRawValue = ContentViewModel.State.start.rawValue
    
    var currentState: ContentViewModel.State {
        ContentViewModel.State(rawValue: currentStateRawValue)!
    }
    
    var body: some View {
        Group {
            switch currentState {
            case .start:
                StartView()
            case .test:
                TestView()
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
