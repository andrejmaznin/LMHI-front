import SwiftUI

struct ResultView: View {
    @ObservedObject var VM = ResultViewModel()
    
    var body: some View {
        VStack {
            Text("Стремления, мотивированные самопониманием")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("Вы противитесь бла бла бла бла бла бла бла бла бла бла бла бла бла бла бла")
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
