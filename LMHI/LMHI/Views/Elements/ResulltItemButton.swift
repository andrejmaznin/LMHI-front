import SwiftUI

struct ResulltItemButton: View {
    var body: some View {
        NavigationButton(destination: ResultItemView(), cornerRadius: 30.0, backgroundColor: .black, height: nil, maxHeight: .infinity) {
            ZStack {
                Image("Books")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct ResulltItemButton_Previews: PreviewProvider {
    static var previews: some View {
        ResulltItemButton()
            .frame(height: 137)
            .padding()
    }
}
