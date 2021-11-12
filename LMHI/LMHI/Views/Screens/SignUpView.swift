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
                        
                    }

                    VStack {
                        
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
            Alert(title: Text("Account creation failure"), message: Text("Unexpected error. Check your internet connection"), dismissButton:  .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
