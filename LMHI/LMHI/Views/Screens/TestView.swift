import SwiftUI

struct TestView: View {
    @ObservedObject var VM = TestViewModel()
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(VM.leftColor)
                .cornerRadius(30.0)
                .frame(width: UIScreen.main.bounds.width / 3)
                .aspectRatio(0.6, contentMode: .fit)
                .onTapGesture {
                    VM.process(.left)
                }
            
            Spacer()
                .frame(width: 30)
            
            Rectangle()
                .foregroundColor(VM.rightColor)
                .cornerRadius(30.0)
                .frame(width: UIScreen.main.bounds.width / 3)
                .aspectRatio(0.6, contentMode: .fit)
                .onTapGesture {
                    VM.process(.right)
                }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
