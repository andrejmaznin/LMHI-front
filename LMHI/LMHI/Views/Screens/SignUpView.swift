import SwiftUI

struct SignUpView: View {    
    @ObservedObject private var VM = SignUpViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                FormTextField(data: $VM.fullName, placeholder: "Full name", autocapitalization: true, validator: VM.validateFullName, prompt: VM.fullNamePrompt)
                
                FormTextField(data: $VM.email, placeholder: "Email", keyboardType: .emailAddress, validator: VM.validateEmail, prompt: VM.emailPrompt)
                
                FormTextField(data: $VM.password, placeholder: "Password", isSecure: true, validator: VM.validatePassword, prompt: VM.passwordPrompt)
                
                HStack {
                    CheckBox(checked: $VM.termsAndConditions)

                    Text("Terms and conditions")
                        .font(Fonts.caption)
                        .foregroundColor(Color(.systemGray))

                    Spacer()
                }
                
                ActionButton(action: VM.signUp, backgroundColor: VM.validateForm() ? Color("StarkWhite") : Color("VistaWhite"), isDisabled: !VM.validateForm()) {
                    Text("Create account")
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
                Text("Sign Up")
            }
        }
        .alert(isPresented: $VM.showAlert) {
            Alert(title: Text("Account creation failure"), message: Text("Unexpected error. Check your internet connection"), dismissButton:  .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
