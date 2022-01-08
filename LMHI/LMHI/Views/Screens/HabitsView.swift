import SwiftUI

struct HabitsView: View {
    var body: some View {
        VStack {
            Text("Track your habits")
                .font(Fonts.title)
            
            Spacer()
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
