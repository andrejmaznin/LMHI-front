import Foundation

struct TestResultInterpretationModel {
    let data: [String: Int]
    
    init(_ id: Int) {
        self.data = ["id": id]
    }
}
