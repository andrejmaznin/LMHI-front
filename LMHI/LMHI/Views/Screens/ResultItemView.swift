import SwiftUI

struct ResultItemView: View {
    var spacing: CGFloat = 20.0
    var title: String
    var text: String
    
    var body: some View {
        VStack(spacing: spacing) {
            Text(title)
                .font(Fonts.label)
                .multilineTextAlignment(.center)
            
            Text(text)
                .multilineTextAlignment(.leading)
            
            Text("Наши предложения")
                .font(Fonts.label)
                .multilineTextAlignment(.center)
            
            SuggestionItem(suggestion: "Медитация")
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Результат")
            }
        }
    }
}

struct ResultItemView_Previews: PreviewProvider {
    static var previews: some View {
        ResultItemView(title: "Стремления, мотивированные самопониманием", text: "Test")
    }
}
