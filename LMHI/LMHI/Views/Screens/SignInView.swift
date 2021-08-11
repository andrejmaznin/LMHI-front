import SwiftUI

struct SignInView: View {
    @State var field: String = ""
    
    var body: some View {
        ZStack {
            Image("Background0")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            VStack {
                FormTextField(placeholder: "Username", prompt: "", field: $field, isSecure: false, autocapitalization: false)
            }
            .padding()
            .ignoresSafeArea(.keyboard)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sign In")
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
