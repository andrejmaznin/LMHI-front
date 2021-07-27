import SwiftUI

struct TextFieldError: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(Color.red)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TextFieldError_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldError(text: "Enter username")
    }
}
