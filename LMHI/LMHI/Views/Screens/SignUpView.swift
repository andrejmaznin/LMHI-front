import SwiftUI

struct SignUpView: View {
    @ObservedObject var VM = SignUpViewModel()
    
    let inactiveColor = Color(R: 230, G: 223, B: 213)
    let activeColor = Color(R: 214, G: 200, B: 181)
    
    var body: some View {
        ZStack {
            ZStack {
                Image("Background0")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    VStack {
                        FormTextField(placeholder: "Full name", prompt: VM.personNamePrompt, field: $VM.personName, isSecure: false, autocapitalization: true)
                        FormTextField(placeholder: "Email", prompt: VM.emailPrompt, field: $VM.email, isSecure: false, autocapitalization: false)
                    }

                    Spacer()

                    VStack {
                        FormTextField(placeholder: "Username", prompt: VM.usernamePrompt, field: $VM.username, isSecure: false, autocapitalization: false)
                        FormTextField(placeholder: "Password", prompt: VM.passwordPrompt, field: $VM.password,  isSecure: true, autocapitalization: false)
                        
                        HStack {
                            CheckBox(checked: $VM.termsAndConditions)

                            Text("Terms and conditions")
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .foregroundColor(Color(.systemGray))
                                .onTapGesture { VM.termsAndConditions.toggle() }

                            Spacer()
                        }
                        
                        FormButton(action: VM.signUp, text: "Create account", color: VM.isFormValid ? activeColor : inactiveColor, disabled: !VM.isFormValid)
                    }
                    
                    Spacer()
                }
                .padding()
                .ignoresSafeArea(.keyboard)
            }
            .brightness(VM.showProgress ? -0.2 : 0)
            
            if VM.showProgress {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 200, height: 100)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        Text("Loading...")
                            .bold()
                            .padding(.bottom, 10)
                        
                        ProgressView()
                            .scaleEffect(2)
                    }
                }
            }
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
