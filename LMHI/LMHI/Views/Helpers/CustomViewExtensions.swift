import SwiftUI

extension View {
    func formTextField(type: FormTextFieldType) -> some View {
        return modifier(FormTextFieldModifier(type: type))
    }
}
