import SwiftUI

struct SignUpView: View {
    @ObservedObject var VM = SignUpViewModel()
    
    let inactiveColor = Color(R: 230, G: 223, B: 213)
    let activeColor = Color(R: 214, G: 200, B: 181)
    
    var body: some View {
        ZStack {
            Image("SignUpBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            ScrollView {
                Spacer()
                    .frame(height: 100)
                
                FormTextField(placeholder: "Full name", prompt: VM.personNamePrompt, field: $VM.personName, action: VM.validatePersonName, isSecure: false, autocapitalization: true)
                FormTextField(placeholder: "Email", prompt: VM.emailPrompt, field: $VM.email, action: VM.validateEmail, isSecure: false, autocapitalization: false)

                Spacer()
                    .frame(height: 60)

                FormTextField(placeholder: "Username", prompt: VM.usernamePrompt, field: $VM.username, action: VM.validateUsername, isSecure: false, autocapitalization: false)
                FormTextField(placeholder: "Password", prompt: VM.passwordPrompt, field: $VM.password, action: VM.validatePassword, isSecure: true, autocapitalization: false)

                HStack() {
                    CheckBox(checked: $VM.termsAndConditions)

                    Text("Terms and conditions")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(Color(.systemGray))
                        .onTapGesture { VM.termsAndConditions.toggle() }

                    Spacer()
                }

                FormButton(action: VM.signUp, text: "Create account", color: VM.isFormValid ? activeColor : inactiveColor, disabled: !VM.isFormValid)
            }
            .padding(30)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sign Up")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
