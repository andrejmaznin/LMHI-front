import Foundation

struct SignInModel: Encodable {
    let id: Int
    let email: String
    let hashed_password: String
    let action: String
}
