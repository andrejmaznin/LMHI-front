import Foundation

struct AllTestsResultsModel: Encodable {
    let data: [String: String]
    
    init(_ token: String) {
        data = ["token": token]
    }
}
