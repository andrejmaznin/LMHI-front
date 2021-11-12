import SwiftUI

struct ActionButton<Content: View>: View {
    var action: () -> Void
    var cornerRadius: CGFloat = 10.0
    var backgroundColor: Color = .clear
    var width: CGFloat? = nil
    var height: CGFloat? = 60.0
    var maxWidth: CGFloat? = .infinity
    var maxHeight: CGFloat? = nil
    var isDisabled: Bool = false
    var content: () -> Content
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                
                content()
            }
            .frame(width: width, height: height)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        }
        .disabled(isDisabled)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(action: {}) {
            Text("Text")
        }
    }
}
