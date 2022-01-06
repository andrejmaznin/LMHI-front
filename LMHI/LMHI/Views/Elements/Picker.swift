import SwiftUI

struct Picker: View {
    let cornerRadius: CGFloat = 40.0
    let color: Color = Color("GovernorBay")
    let strokeWidth: CGFloat = 2.0
    let title: String
    let lineColor: Color = Color("PinkSwan")
    let lineHeight: CGFloat = 5.0
    let horizontalPadding: CGFloat = 50.0
    let unselectedCircleDiameter: CGFloat = 20.0
    let unselectedCircleStroke: CGFloat = 5.0
    let selectedCircleDiameter: CGFloat = 30.0
    let selectedCircleStroke: CGFloat = 6.0
    let labels = ["--", "-", "0", "+", "++"]
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
                
                ZStack {
                    Rectangle()
                        .padding(.horizontal, horizontalPadding)
                        .foregroundColor(lineColor)
                        .frame(height: lineHeight)
                    
                    HStack {
                        ForEach(-2...2, id: \.self) { i in
                            if i > -2 {
                                Spacer()
                            }
                            
                            Circle()
                                .fill(Color("Whisper"))
                                .frame(width: unselectedCircleDiameter, height: unselectedCircleDiameter)
                                .background(Circle().stroke(.black, lineWidth: unselectedCircleStroke))
                                .onTapGesture {
                                    currentSelection = i
                                }
                        }
                    }
                    .padding(.horizontal, horizontalPadding - unselectedCircleDiameter / 2.0)
                    
                    HStack {
                        ForEach(-2...2, id: \.self) { i in
                            if i > -2 {
                                Spacer()
                            }
                            
                            Circle()
                                .fill(.white)
                                .frame(width: selectedCircleDiameter, height: selectedCircleDiameter)
                                .background(Circle().stroke(color, lineWidth: selectedCircleStroke))
                                .opacity(currentSelection == i ? 1.0 : 0.0)
                        }
                    }
                    .padding(.horizontal, horizontalPadding - selectedCircleDiameter / 2.0)
                }
                
                HStack {
                    ForEach(labels, id: \.self) { label in
                        if label != labels[0] {
                            Spacer()
                        }
                        
                        VStack(alignment: .center) {
                            Text(label)
                                .allowsTightening(true)
                                .minimumScaleFactor(0.1)
                                .foregroundColor(color)
                                .font(Fonts.label)
                        }
                        .frame(width: selectedCircleDiameter, height: selectedCircleDiameter)
                    }
                }
                .padding(.horizontal, horizontalPadding - selectedCircleDiameter / 2.0)
            }
            .padding(.vertical)
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
    var id: Int
    
    @Binding var currentSelection: Int
    
    var currentDiameter: CGFloat {
        currentSelection == id ? selectedCircleDiameter : unselectedCircleDiameter
    }
    
    var currentStroke: CGFloat {
        currentSelection == id ? selectedStrokeWidth : unselectedStrokeWidth
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(currentSelection == id ? color : strokeColor, lineWidth: currentStroke)
            
            Circle()
                .foregroundColor(Color("Whisper"))
        }
        .offset(x: -currentDiameter / 2.0)
        .frame(width: currentDiameter, height: currentDiameter)
        .onTapGesture {
            currentSelection = id
        }
    }
}

struct Picker_Previews: PreviewProvider {
    static var previews: some View {
        Picker(title: "Ваша Мотивация", currentSelection: .constant(0))
            .padding()
    }
}
