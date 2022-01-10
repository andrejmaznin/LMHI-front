import SwiftUI

struct ResulltItemButton: View {
    var title: String
    var interpretation: String?
    var cornerRadius: CGFloat = 30.0
    var height: CGFloat? = nil
    var maxHeight: CGFloat? = .infinity
    var image: Image
    var color: Color
    var padding: CGFloat = 80.0
    
    var body: some View {
        Section {
            if let text = interpretation {
                NavigationButton(destination: ResultItemView(title: title, text: text), cornerRadius: cornerRadius, height: height, maxHeight: maxHeight) {
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
                            Text(title)
                                .font(Fonts.label)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .padding(.trailing, padding)
                                .minimumScaleFactor(0.1)
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct ResulltItemButton_Previews: PreviewProvider {
    static var previews: some View {
        ResulltItemButton(title: "Стремления, мотивированные самопониманием", interpretation: "Test", image: Image("Meditation"), color: Color("Highball"))
            .frame(height: 137)
            .padding()
    }
}
