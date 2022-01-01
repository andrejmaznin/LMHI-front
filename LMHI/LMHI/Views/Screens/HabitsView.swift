import SwiftUI

struct HabitsView: View {
    var body: some View {
        VStack {
            Text("Track your habbits")
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
