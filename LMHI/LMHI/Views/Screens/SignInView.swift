import SwiftUI

struct SignInView: View {
    @ObservedObject var VM = SignInViewModel()
    
    let inactiveColor = Color(R: 230, G: 223, B: 213)
    let activeColor = Color(R: 214, G: 200, B: 181)
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Spacer()
                    
                    FormTextField(placeholder: "Email", prompt: VM.emailPrompt, field: $VM.email, isSecure: false, autocapitalization: false)
                    FormTextField(placeholder: "Password", prompt: VM.passwordPrompt, field: $VM.password, isSecure: true, autocapitalization: false)
                    
                    FormButton(action: VM.signIn, text: "Log In", color: activeColor, disabled: false)
                    
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
                        .shadow(radius: 10)
                    
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
                Text("Sign In")
            }
        }
        .alert(isPresented: $VM.showAlert) {
            Alert(title: Text("Authentication failure"), message: Text("Unexpected error. Check your internet connection"), dismissButton:  .default(Text("OK")))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
