import Foundation

class MeditationViewModel: ObservableObject {
    enum StopwatchMode {
        case initial
        case running
        case finished
    }
    
    @Published var stopwatchMode: StopwatchMode
    @Published var seconds: Int
    @Published var minutes: Int
    
    private var timer: Timer
    
    init() {
        stopwatchMode = .initial
        seconds = 0
        minutes = 0
        timer = Timer()
    }
    
    func start() {
        stopwatchMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] timer in
            self.seconds += 1
            if self.seconds == 60 {
                self.seconds = 0
                self.minutes += 1
            }
            if self.minutes == 60 {
                stopwatchMode = .finished
            }
        }
    }
    
    func stop() {
        stopwatchMode = .finished
        timer.invalidate()
        //send result to server
    }
    
    func reset() {
        if stopwatchMode == .finished {
            stopwatchMode = .initial
            seconds = 0
            minutes = 0
            timer = Timer()
        }
    }
}
