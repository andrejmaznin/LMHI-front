import SwiftUI

struct SignInView: View {
    @ObservedObject private var VM = SignInViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                FormTextField(data: $VM.email, placeholder: "Email", keyboardType: .emailAddress, prompt: VM.emailPrompt)
                
                FormTextField(data: $VM.password, placeholder: "Password", isSecure: true, prompt: VM.passwordPrompt)
                
                ActionButton(action: VM.signIn, backgroundColor: VM.isCorrect ? Color("StarkWhite") : Color("VistaWhite"), isDisabled: !VM.isCorrect) {
                    Text("Log In")
                        .font(Fonts.label)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding()
            .ignoresSafeArea(.keyboard)
            
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
