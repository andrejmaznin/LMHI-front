import Foundation

struct SignInModel: Encodable {
    let login: String
    let action: String
    let hashed_password: String
}
