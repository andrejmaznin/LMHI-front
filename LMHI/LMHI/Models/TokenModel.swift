import Foundation

struct TokenModel: Encodable {
    let data: [String: String]
    
    init(_ token: String) {
        data = ["token": token]
    }
}
