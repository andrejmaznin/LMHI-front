import SwiftUI

struct Picker: View {
    let cornerRadius: CGFloat = 40.0
    let color: Color = Color("GovernorBay")
    let lineColor: Color = Color("PinkSwan")
    let lineHeight: CGFloat = 5.0
    let strokeWidth: CGFloat = 2.0
    let circleDiameter: CGFloat = 20.0
    var linePadding: CGFloat = 60.0
    var topPadding: CGFloat = 60.0
    var title: String
    let aspectRatio: CGFloat = 3.15
    let maxWidth: CGFloat? = UIScreen.main.bounds.width
    let maxHeight: CGFloat? = nil
    
    @Binding var currentSelection: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: strokeWidth)
            
            VStack {
                Text(title)
                    .foregroundColor(color)
                    .font(Fonts.label)
                    .padding(.top)
                
                Spacer()
            }
            
            VStack {
                Rectangle()
                    .foregroundColor(lineColor)
                    .frame(height: lineHeight)
                    .padding(.top, topPadding)
                
                Spacer()
            }
            .padding(.horizontal, linePadding)
            
            VStack {
                HStack {
                    ChoiceElement(label: "--", id: -2, currentSelection: $currentSelection)
                    
                    Spacer()
                    
                    ChoiceElement(label: "-", id: -1, currentSelection: $currentSelection)
                    
                    Spacer()
                    
                    ChoiceElement(label: "0", id: 0, currentSelection: $currentSelection)
                    
                    Spacer()
                    
                    ChoiceElement(label: "+", id: 1, currentSelection: $currentSelection)
                    
                    Spacer()
                    
                    ChoiceElement(label: "++", id: 2, currentSelection: $currentSelection)
                }
                .padding(.top, topPadding - (30.0 - lineHeight) / 2.0)
                
                Spacer()
            }
            .padding(.horizontal, linePadding - 10.0)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

struct ChoiceElement: View {
    let strokeColor: Color = Color.black
    let unselectedStrokeWidth: CGFloat = 5.0
    let selectedStrokeWidth: CGFloat = 6.0
    let unselectedCircleDiameter: CGFloat = 20.0
    let selectedCircleDiameter: CGFloat = 30.0
    let color: Color = Color("GovernorBay")
    var label: String
    var id: Int
    
    @Binding var currentSelection: Int
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(currentSelection == id ? color : strokeColor, lineWidth: currentSelection == id ? selectedStrokeWidth : unselectedStrokeWidth)
                
                Circle()
                    .foregroundColor(Color("Whisper"))
            }
            .frame(width: currentSelection == id ? selectedCircleDiameter : unselectedCircleDiameter, height: currentSelection == id ? selectedCircleDiameter : unselectedCircleDiameter)
            .onTapGesture {
                currentSelection = id
            }
            
            Text(label)
                .foregroundColor(color)
                .font(Fonts.label)
        }
    }
}

struct Picker_Previews: PreviewProvider {
    static var previews: some View {
        Picker(title: "Ваша Мотивация", currentSelection: .constant(0))
            .padding()
    }
}
