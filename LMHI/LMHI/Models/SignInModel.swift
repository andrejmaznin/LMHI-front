import Foundation

struct SignInModel: Encodable {
    let login: String
    let action = "login"
    let hashed_password: String
}
