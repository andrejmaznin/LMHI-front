import SwiftUI

struct CheckBox: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var checked: Bool
    
    var cornerRadius: CGFloat = 5.0
    var strokeWidth: CGFloat = 2.0
    var width: CGFloat = 30.0
    var height: CGFloat = 30.0
    
    var backgroundColor: Color {
        colorScheme == .dark ? Color("Madison") : .white
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color(.systemGray4), lineWidth: strokeWidth)
            
            Group {
                if checked {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .frame(width: width - 2 * strokeWidth, height: height - 2 * strokeWidth)
                        .foregroundColor(Color(.systemBlue))
                }
            }
        }
        .frame(width: width, height: height)
        .onTapGesture {
            checked.toggle()
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(checked: .constant(true))
    }
}
