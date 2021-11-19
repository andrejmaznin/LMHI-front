import SwiftUI

struct TestResultsView: View {
    var body: some View {
        VStack {
            //temp
            HStack {
                Spacer()
                
                Button("Log Out") {
                    AppState.logOut()
                }
            }
            
            Text("Результаты")
                .font(Fonts.title)
            
            
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct TestResultsView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultsView()
    }
}
