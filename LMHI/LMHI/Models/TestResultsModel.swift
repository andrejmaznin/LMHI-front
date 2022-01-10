import Foundation

struct TestResultsModel: Encodable {
    struct TestResult: Encodable {
        let finished: Bool
        let main: String
        let blue: String
        let green: String
        let red: String
        let yellow: String
    }
    
    let test_result: TestResult
    
    init(_ result: [String]) {
        self.test_result = TestResult(finished: true, main: result[0], blue: result[1], green: result[2], red: result[3], yellow: result[4])
    }
}
