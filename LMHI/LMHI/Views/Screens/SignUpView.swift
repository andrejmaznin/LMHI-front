import SwiftUI

struct SignUpView: View {
    @ObservedObject var VM = SignUpViewModel()
    
    let inactiveColor = Color(R: 230, G: 223, B: 213)
    let activeColor = Color(R: 214, G: 200, B: 181)
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Spacer()
                    
                    VStack {
                        FormTextField(placeholder: "Full name", prompt: VM.personNamePrompt, field: $VM.personName, isSecure: false, autocapitalization: true)
                        FormTextField(placeholder: "Email", prompt: VM.emailPrompt, field: $VM.email, isSecure: false, autocapitalization: false)
                    }

                    VStack {
                        FormTextField(placeholder: "Password", prompt: VM.passwordPrompt, field: $VM.password, isSecure: true, autocapitalization: false)
                        
                        FormButton(action: VM.signUp, text: "Create account", color: activeColor, disabled: false)
                    }
                    
                    Spacer()
                }
                .padding()
                .ignoresSafeArea(.keyboard)
            }
            
            if VM.showLoading {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 200, height: 100)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    VStack {
                        ProgressView()
                            .scaleEffect(2)
                        
                        Text("Loading...")
                            .bold()
                            .padding(.top, 20)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sign Up")
            }
        }
        .alert(isPresented: $VM.showAlert) {
            Alert(title: Text("Account creation error"), message: Text("Unexpected error"), dismissButton:  .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
