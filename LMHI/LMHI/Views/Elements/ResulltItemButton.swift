import SwiftUI

struct ResulltItemButton: View {
    var title: String
    var resultName: String
    var cornerRadius: CGFloat
    var height: CGFloat? = nil
    var maxHeight: CGFloat? = .infinity
    var image: Image
    var color: Color
    private var text: String
    var padding: CGFloat
    
    init(title: String, resultName: String, cornerRadius: CGFloat = 30.0, height: CGFloat? = nil, maxHeight: CGFloat? = .infinity, image: Image, color: Color, padding: CGFloat = 80.0) {
        self.title = title
        self.resultName = resultName
        self.cornerRadius = cornerRadius
        self.height = height
        self.maxHeight = maxHeight
        self.image = image
        self.color = color
        self.text = AppState.load(key: resultName, defaultValue: "empty")
        self.padding = padding
    }
    
    var body: some View {
        Group {
            if text != "ERROR" {
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
        ResulltItemButton(title: "Стремления, мотивированные самопониманием", resultName: "testMainResult", image: Image("Meditation"), color: Color("Highball"))
            .frame(height: 137)
            .padding()
    }
}
