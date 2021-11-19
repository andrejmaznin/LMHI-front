import SwiftUI

struct ResultItemView: View {
    var spacing: CGFloat = 20.0
    var title: String
    private var text: String
    
    init(spacing: CGFloat = 20.0, title: String, resultName: String) {
        self.spacing = spacing
        self.title = title
        self.text = AppState.load(key: resultName, defaultValue: "empty")
    }
    
    var body: some View {
        VStack(spacing: spacing) {
            Text(title)
                .font(Fonts.label)
                .multilineTextAlignment(.center)
            
            Text(text)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Result")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Group {
                    if AppState.isInDebugMode {
                        Button("Log Out") {
                            AppState.logOut()
                        }
                    }
                }
            }
        }
    }
}

struct ResultItemView_Previews: PreviewProvider {
    static var previews: some View {
        ResultItemView(title: "Стремления, мотивированные самопониманием", resultName: "testMainResult")
    }
}
