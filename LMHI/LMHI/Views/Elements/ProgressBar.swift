import SwiftUI

struct ProgressBar: View {
    let title: String
    let current: Int
    let goal: Int
    let foregroundColor: Color
    let backgroundColor: Color
    
    private var progress: Double {
        Double(current) / Double(goal)
    }
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .frame(width: CGFloat(progress) * metrics.size.width)
                    .foregroundColor(foregroundColor)
                
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        Text("\(current) min")
                        
                        Text("\(Int((progress * 100.0).rounded()))%")
                    }
                    .padding()
                }
                .font(.system(size: 24))
                .foregroundColor(.white)
            }
            .cornerRadius(30.0)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
        .aspectRatio(2.5, contentMode: .fit)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(
            title: "Meditation",
            current: 20,
            goal: 30,
            foregroundColor: Color(R: 246, G: 207, B: 69),
            backgroundColor: Color(R: 240, G: 222, B: 175)
        )
    }
}
