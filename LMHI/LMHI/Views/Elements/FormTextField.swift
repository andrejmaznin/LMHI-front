import SwiftUI

struct FormTextField: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var data: String
    
    var cornerRadius: CGFloat = 10.0
    var strokeWidth: CGFloat = 2.0
    var placeholder: String = ""
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: Bool = false
    var width: CGFloat? = nil
    var height: CGFloat? = 60.0
    var maxWidth: CGFloat? = .infinity
    var maxHeight: CGFloat? = nil
    var prompt: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colorScheme == .dark ? Color("Madison") : .white)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.systemGray4), lineWidth: strokeWidth)
                
                HStack {
                    Group {
                        if data.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                
                Group {
                    if isSecure {
                        SecureField("", text: $data)
                    } else {
                        TextField("", text: $data)
                    }
                }
                .padding()
                .disableAutocorrection(true)
                .keyboardType(keyboardType)
                .autocapitalization(autocapitalization ? .words : .none)
            }
            .frame(width: width, height: height)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
            
            if !prompt.isEmpty {
                HStack {
                    Text(prompt)
                        .font(Fonts.caption)
                        .foregroundColor(.red)
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
        FormTextField(data: .constant(""))
    }
}
