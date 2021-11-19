import SwiftUI

struct TestResultsView: View {
    private var spacing: CGFloat = 20.0
    
    var body: some View {
        NavigationView {
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
                
                VStack(spacing: spacing) {
                    ResulltItemButton(destination: ResultItemView(), image: Image("Books"), color: Color("Highball"), text: "Стремления, мотивированные самопониманием")
                    
                    ResulltItemButton(destination: ResultItemView(), image: Image("Family"), color: Color("GovernorBay"), text: "Эмоциональное отношение к высокозначимым лицам")
                    
                    ResulltItemButton(destination: ResultItemView(), image: Image("Runner"), color: Color("Parsley"), text: "Характеристика воли и самооценка")
                    
                    ResulltItemButton(destination: ResultItemView(), image: Image("Meditation"), color: Color("MandarianOrange"), text: "Возбудимость и импульсивность")
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct TestResultsView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultsView()
    }
}
