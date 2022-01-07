import SwiftUI

struct TestView: View {
    @ObservedObject private var VM = TestViewModel()
    
    private var cornerRadius: CGFloat = 30.0
    private var aspectRatio: CGFloat = 0.5
    
    var body: some View {
        Group {
            switch VM.testState {
            case .initial:
                VStack {
                    Text("Выберите более симпатичный цвет")
                        .font(Fonts.regular)
                        .multilineTextAlignment(.center)
                        .padding(.top, UIScreen.main.bounds.height / 6)
                    
                    HStack {
                        Spacer()
                        
                        Rectangle()
                            .foregroundColor(VM.leftColor)
                            .cornerRadius(cornerRadius)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 3)
                            .onTapGesture {
                                VM.process(.left)
                            }
                            .disabled(VM.showAlert)
                        
                        Spacer()
                        
                        Rectangle()
                            .foregroundColor(VM.rightColor)
                            .cornerRadius(cornerRadius)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 3)
                            .onTapGesture {
                                VM.process(.right)
                            }
                        
                        Spacer()
                    }
                    .padding(.top, 60)
                    
                    Spacer()
                }
                .padding()
            case .completed:
                LoadingCover(isPresented: VM.showLoadingCover)
                    .alert(isPresented: $VM.showAlert) {
                        Alert(title: Text("Test Results Submition Failure"), message: Text("Unexpected error. Check your internet connection"), dismissButton:  .default(Text("OK")))
                    }
            case .resultsReceived:
                NavigationView {
                    VStack {
                        TestResultsView(results: VM.results)
                            .navigationBarTitleDisplayMode(.inline)
                        
                        ActionButton(action: { AppState.setState(.home) }, backgroundColor: Color("StarkWhite")) {
                            Text("Далее")
                                .font(Fonts.label)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
