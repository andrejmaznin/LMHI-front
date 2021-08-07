import SwiftUI

struct Default: View {
    var body: some View {
        Text("LMHI")
            .font(.system(size: 42, weight: .bold, design: .default))
            .padding()
    }
}

struct Default_Previews: PreviewProvider {
    static var previews: some View {
        Default()
    }
}
