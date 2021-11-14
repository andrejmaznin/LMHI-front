import SwiftUI

struct TestView: View {
    @ObservedObject private var VM = TestViewModel()
    
    private var cornerRadius: CGFloat = 30.0
    private var aspectRatio: CGFloat = 0.6
    
    var body: some View {
        ZStack {
            NavigationView {
                HStack {
                    Rectangle()
                        .foregroundColor(VM.leftColor)
                        .cornerRadius(cornerRadius)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .onTapGesture {
                            VM.process(.left)
                        }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Rectangle()
                        .foregroundColor(VM.rightColor)
                        .cornerRadius(cornerRadius)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .onTapGesture {
                            VM.process(.right)
                        }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Test")
                    }
                }
                .alert(isPresented: $VM.showAlert) {
                    Alert(title: Text("Test Results Submition Failure"), message: Text("Unexpected error. Check your internet connection"), dismissButton:  .default(Text("OK")))
                }
            }
            
            LoadingCover(isPresented: VM.showLoadingCover)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
