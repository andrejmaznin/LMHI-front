import Foundation

struct SignUpModel: Encodable {
    let name: String
    let hashed_password: String
    let email: String
    let info: String
}
