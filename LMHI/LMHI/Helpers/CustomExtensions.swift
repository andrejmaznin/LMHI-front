import SwiftUI

extension View {
    func formTextField(autocapitalization: Bool) -> some View {
        return modifier(FormTextFieldModifier(autocapitalization: autocapitalization))
    }
}

extension Color {
    init(R: Int, G: Int, B: Int) {
        self.init(red: Double(R) / 255.0, green: Double(G) / 255.0, blue: Double(B) / 255.0)
    }
}
