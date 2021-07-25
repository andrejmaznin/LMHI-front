import SwiftUI

extension View {
    func formTextField() -> some View {
        self
            .padding()
            .frame(height: 60)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
            .padding(.top, 10)
            .padding(.bottom, 10)
    }
}
