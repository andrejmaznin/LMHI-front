import Foundation

struct SignOutModel: Encodable {
    let login: String
    let action = "exit"
    let id: Int
}
