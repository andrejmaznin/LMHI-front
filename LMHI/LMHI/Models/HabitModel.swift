import Foundation

struct HabitModel: Codable {
    let id: Int
    let name: String
    let boolean: Bool
    let lower: Int
    let upper: Int
    let value: String
}
