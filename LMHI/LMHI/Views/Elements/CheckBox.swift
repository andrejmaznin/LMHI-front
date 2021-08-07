import SwiftUI

struct CheckBox: View {
    @Binding var checked: Bool
    
    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .resizable()
            .background(Color(.white))
            .foregroundColor(checked ? Color(.systemBlue) : Color(.white))
            .frame(width: 30, height: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray4), lineWidth: 2)
            )
            .onTapGesture {
                checked.toggle()
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .padding(.leading, 2)
            .padding(.trailing, 10)
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(checked: .constant(false))
    }
}
