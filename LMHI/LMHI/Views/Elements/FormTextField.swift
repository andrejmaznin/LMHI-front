import SwiftUI

struct FormTextField: View {
    let placeholder: String
    let prompt: String
    @Binding var field: String
    let isSecure: Bool
    let autocapitalization: Bool
    
    @State private var wasTouched = false
    
    var body: some View {
        VStack {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $field)
                } else {
                    TextField(placeholder, text: $field)
                }
            }
            .padding()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color(.white))
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
            .disableAutocorrection(true)
            .autocapitalization(autocapitalization ? .words : .none)
            
            if !prompt.isEmpty {
                HStack {
                    Text(prompt)
                        .font(.system(size: 16))
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 10)
    }
}

struct FormTextField_Previews: PreviewProvider {
    static var previews: some View {
        FormTextField(placeholder: "Username", prompt: "", field: .constant(""), isSecure: false, autocapitalization: false)
    }
}
