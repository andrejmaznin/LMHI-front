import SwiftUI

struct TestView: View {
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(.blue)
                .cornerRadius(30.0)
                .frame(width: UIScreen.main.bounds.width / 3)
                .aspectRatio(0.6, contentMode: .fit)
            
            Spacer()
                .frame(width: 30)
            
            Rectangle()
                .foregroundColor(.blue)
                .cornerRadius(30.0)
                .frame(width: UIScreen.main.bounds.width / 3)
                .aspectRatio(0.6, contentMode: .fit)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
