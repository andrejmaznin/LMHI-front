import SwiftUI

struct SignInView: View {
    @ObservedObject private var VM = SignInViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                FormTextField(data: $VM.email, placeholder: "Email", keyboardType: .emailAddress, validator: VM.validateEmail, prompt: VM.emailPrompt)
                
                FormTextField(data: $VM.password, placeholder: "Password", isSecure: true, validator: VM.validatePassword, prompt: VM.passwordPrompt)
                
                ActionButton(action: VM.signIn, backgroundColor: VM.validateForm() ? Color("StarkWhite") : Color("VistaWhite"), isDisabled: !VM.validateForm()) {
                    Text("Log In")
                        .font(Fonts.label)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding()
            .ignoresSafeArea(.keyboard)
            
            LoadingCover(isPresented: VM.showLoadingCover)
        }
        .navigationBarBackButtonHidden(VM.showLoadingCover ? true : false)
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
