import SwiftUI

extension Color {
    init(R: Int, G: Int, B: Int) {
        self.init(red: Double(R) / 255.0, green: Double(G) / 255.0, blue: Double(B) / 255.0)
    }
    
    init(_ name: String) {
        if let color = UIColor(named: name) {
            self.init(color)
        } else {
            fatalError("Trying to initialize with nonexistent color " + name)
        }
    }
}
