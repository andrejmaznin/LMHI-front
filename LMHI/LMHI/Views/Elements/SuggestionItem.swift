import SwiftUI

struct SuggestionItem: View {
    let cornerRadius: CGFloat = 30.0
    var color: Color = Color("GovernorBay")
    let strokeWidth: CGFloat = 1.0
    let circleDiameter: CGFloat = 50.0
    let width: CGFloat? = nil
    let height: CGFloat? = 70.0
    let maxWidth: CGFloat? = .infinity
    let maxHeight: CGFloat? = nil
    
    var suggestion: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: strokeWidth)
            
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: circleDiameter, height: circleDiameter)
                
                Text(suggestion)
                    .foregroundColor(color)
                    .font(Fonts.semibold)
                
                Spacer()
            }
            .padding()
        }
        .frame(width: width, height: height)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
}

struct SuggestionItem_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionItem(suggestion: "Медитация")
            .padding()
    }
}
