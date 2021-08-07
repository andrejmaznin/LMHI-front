import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("SignUpBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                VStack {
                    Text("Welcome to LMHI!")
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .padding(.top)
                    
                    Spacer()
                    
                    NavigationLink(destination: SignInView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                            
                            Text("Login")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink(destination: SignUpView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green)
                            
                            Text("Create Account")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarHidden(true)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
