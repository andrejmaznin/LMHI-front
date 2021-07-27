import SwiftUI

struct FormTextFieldModifier: ViewModifier {
    let type: FormTextFieldType
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 60)
            .background(Color(.white))
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
            .autocapitalization(type == .personName ? .words : .none)
            .disableAutocorrection(true)
    }
}
