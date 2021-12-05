import SwiftUI

struct ResulltItemButton<Destination: View>: View {
    var destination: Destination
    var cornerRadius: CGFloat = 30.0
    var height: CGFloat? = nil
    var maxHeight: CGFloat? = .infinity
    var image: Image
    var color: Color
    var text: String
    var padding: CGFloat = 80.0
    
    var body: some View {
        NavigationButton(destination: destination, cornerRadius: cornerRadius, height: height, maxHeight: maxHeight) {
            ZStack {
                HStack {
                    Spacer()
                    
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        color,
                        color,
                        color,
                        .clear
                    ]),
                   startPoint: .leading,
                   endPoint: .trailing
                )
                
                HStack {
                    Text(text)
                        .font(Fonts.label)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing, padding)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ResulltItemButton_Previews: PreviewProvider {
    static var previews: some View {
        ResulltItemButton(destination: ResultItemView(title: "", resultName: "testMainResult"), image: Image("Meditation"), color: Color("Highball"), text: "Стремления, мотивированные самопониманием")
            .frame(height: 137)
            .padding()
    }
}
