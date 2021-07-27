import SwiftUI

struct SignUp: View {
    let inactiveColor = Color(
        red: Util.normalizeColor(230),
        green: Util.normalizeColor(223),
        blue: Util.normalizeColor(213)
    )
    let activeColor = Color(
        red: Util.normalizeColor(214),
        green: Util.normalizeColor(200),
        blue: Util.normalizeColor(181)
    )
    
    @State private var form = ["", "", "", ""]
    @State private var valid = [false, false, false, false, false]
    
    var body: some View {
        ZStack {
            Image("SignUpBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            ScrollView {
                Spacer()
                    .frame(height: 100)
                
                FormTextField(type: .personName, form: $form, valid: $valid)
                FormTextField(type: .email, form: $form, valid: $valid)

                Spacer()
                    .frame(height: 60)

                FormTextField(type: .username, form: $form, valid: $valid)
                FormTextField(type: .password, form: $form, valid: $valid)

                HStack() {
                    CheckBox(checked: $valid[4])

                    Text("Terms and conditions")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(.systemGray))
                        .onTapGesture { valid[4].toggle() }

                    Spacer()
                }

                Button(action: { signUp() }) {
                    Text("Create account")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Util.arrayAndOperation(valid) ? activeColor : inactiveColor
                )
                .disabled(!Util.arrayAndOperation(valid))
                .padding(.top, 10)
            }
            .padding(30)
        }
    }
    
    func signUp() {
        print("Sign up")
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
