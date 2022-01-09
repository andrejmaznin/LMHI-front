import SwiftUI

struct ProgressBar: View {
    let title: String
    let goal: Int
    let upper: Int
    let value: String
    let foregroundColor: Color = Color("Festival")
    let backgroundColor: Color = Color("Wheat")
    let completedColor: Color = Color("Green")
    
    let cornerRadius: CGFloat = 30.0
    let aspectRatio: CGFloat = 4.0
    
    @State var current: Int = 0
    
    private var progress: Double {
        Double(current) / Double(upper)
    }
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .frame(width: CGFloat(progress) * metrics.size.width)
                    .foregroundColor(foregroundColor)
                    .gesture(DragGesture().onChanged { (value) in
                        print(value)
                    })
                
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        Text(String(current) + "/" + String(upper) + " " + value)
                        
                        Text("min " + String(goal))
                    }
                    .padding()
                }
                .font(.system(size: 24))
                .foregroundColor(.white)
            }
            .cornerRadius(cornerRadius)
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width)
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(
            title: "Drink your water",
            goal: 1200,
            upper: 2500,
            value: "ml"
        )
    }
}
