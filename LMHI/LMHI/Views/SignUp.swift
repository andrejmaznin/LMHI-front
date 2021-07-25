import SwiftUI

struct SignUp: View {
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var password = ""
    @State private var acceptedAgreement = false
    
    var body: some View {
        VStack {
            TextField("Full name", text: $name)
                .formTextField()
            TextField("Phone number", text: $phoneNumber)
                .formTextField()
            
            Spacer()
                .frame(height: 60)
            
            TextField("Email", text: $email)
                .formTextField()
            SecureField("Password", text: $password)
                .formTextField()
            
            HStack() {
                CheckBox(checked: $acceptedAgreement)
                
                Text("Terms and conditions")
                    .font(.system(size: 20))
                
                Spacer()
            }
            
            Button(action: { signUp() }) {
                Text("Create account")
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color(
                        red: Util.normalizeColor(56),
                        green: Util.normalizeColor(69),
                        blue: Util.normalizeColor(165)
                    ))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding(30)
    }
    
    func signUp() {
        
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
