import SwiftUI

struct NavigationButton<Destination: View, Content: View>: View {
    var destination: Destination
    var cornerRadius: CGFloat = 10.0
    var width: CGFloat? = nil
    var height: CGFloat? = 60.0
    var maxWidth: CGFloat? = .infinity
    var maxHeight: CGFloat? = nil
    var backgroundColor: Color = .clear
    var content: () -> Content
    
    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                
                content()
            }
            .frame(width: width, height: height)
            .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        }
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(destination: SignInView()) {
            Text("Text")
        }
    }
}
