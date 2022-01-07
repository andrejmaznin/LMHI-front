import SwiftUI

struct TestsMenuView: View {
    @ObservedObject var VM = TestsMenuViewModel()
    
    let buttonColor = Color("StarkWhite")
    let buttonHeight: CGFloat = 80.0
    
    var body: some View {
        Group {
            if VM.loading {
                LoadingCover()
                    .navigationBarBackButtonHidden(true)
            } else {
                VStack(alignment: .leading) {
                    ActionButton (action: { AppState.setState(.test) }, backgroundColor: .green, height: buttonHeight) {
                        Text("Пройти цветовой тест")
                            .foregroundColor(.white)
                            .font(Fonts.label)
                    }
                    .padding(.vertical)
                    
                    Text("Результаты предыдущих тестов")
                        .font(Fonts.title)
                }
                .padding()
                .navigationTitle("Тесты")
            }
        }
        .alert(isPresented: $VM.showAlert) {
            Alert(title: Text("Failed to Recieve Tests Results"), message: Text("Unexpected error. Check your internet connection"), dismissButton:  .default(Text("OK")))
        }
    }
}

struct TestsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TestsMenuView()
    }
}
