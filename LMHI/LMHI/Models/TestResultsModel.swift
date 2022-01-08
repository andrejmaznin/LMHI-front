import Foundation

struct TestResultsModel: Encodable {
    struct TestResult: Encodable {
        let finished: Bool
        let result: [Int]
    }
    
    let test_result: TestResult
    
    init(_ result: [Int]) {
        self.test_result = TestResult(finished: true, result: result)
    }
}
