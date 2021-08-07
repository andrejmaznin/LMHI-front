import SwiftUI

struct FormButton: View {
    let action: () -> Void
    let text: String
    let color: Color
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct FormButton_Previews: PreviewProvider {
    static var previews: some View {
        FormButton(action: {}, text: "Text", color: Color.blue)
    }
}
