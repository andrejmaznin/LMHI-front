import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to LMHI!")
                    .font(Fonts.title)
                    .padding(.top)
                
                Spacer()
                
                Text("App Info")
                    .font(Fonts.regular)
                
                Spacer()
                
                NavigationButton(destination: SignInView(), backgroundColor: .blue) {
                    Text("Login")
                        .font(Fonts.label)
                        .foregroundColor(.white)
                }
                
                NavigationButton(destination: SignUpView(), backgroundColor: .green) {
                    Text("Create Account")
                        .font(Fonts.label)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
