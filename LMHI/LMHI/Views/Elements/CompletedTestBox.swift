import SwiftUI

struct CompletedTestBox: View {
    let cornerRadius: CGFloat = 20.0
    let strokeColor = Color(.black)
    let strokeWidth = 4.0
    let backgroundColor = Color("PinkSwan")
    let index: Int
    let date: String
    let buttonAscpectRatio: CGFloat = 1.5
    let results: [String?]
    let width: CGFloat? = nil
    let height: CGFloat = 100.0
    let maxWidth: CGFloat? = .infinity
    let maxHeight: CGFloat? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Тест #\(index)")
                        .font(Fonts.label)
                    
                    Spacer()
                    
                    Text("от \(date)")
                        .font(Fonts.label)
                        .minimumScaleFactor(0.1)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                NavigationButton(destination: TestResultsView(results: results), cornerRadius: cornerRadius, backgroundColor: .gray, height: height / 2.0) {
                    Text("Посмотреть")
                        .foregroundColor(.white)
                        .font(Fonts.label)
                }
            }
            .padding()
        }
        .frame(width: width, height: height)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
    }
}

struct CompletedTestBox_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTestBox(index: 1, date: "1.01.2022 16:00", results: [""])
            .padding()
    }
}
