import SwiftUI

struct ProgressBar: View {
    let title: String
    let currentMinutes: Int
    let goalMinutes: Int
    let foregroundColor: Color
    let backgroundColor: Color
    
    private var progress: Double {
        Double(currentMinutes) / Double(goalMinutes)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .frame(width: CGFloat(progress) * geometry.size.width)
                    .foregroundColor(foregroundColor)
                
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        Text("\(currentMinutes) min")
                        
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
            currentMinutes: 20,
            goalMinutes: 30,
            foregroundColor: Color(
                red: Util.normalizeColor(246),
                green: Util.normalizeColor(207),
                blue: Util.normalizeColor(69)
            ),
            backgroundColor: Color(
                red: Util.normalizeColor(240),
                green: Util.normalizeColor(222),
                blue: Util.normalizeColor(175)
            )
        )
    }
}
