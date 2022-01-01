import SwiftUI

struct TestResultsView: View {
    private var spacing: CGFloat = 20.0
    private var titles = [
        "Стремления, мотивированные самопониманием",
        "Эмоциональное отношение к высокозначимым лицам",
        "Характеристика воли и самооценка",
        "Возбудимость и импульсивность"
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Результаты")
                    .font(Fonts.title)
                
                VStack(spacing: spacing) {
                    ResulltItemButton(title: titles[0], resultName: "testYellowResult", image: Image("Books"), color: Color("Highball"))
                    
                    ResulltItemButton(title: titles[1], resultName: "testBlueResult", image: Image("Family"), color: Color("GovernorBay"))
                    
                    ResulltItemButton(title: titles[2], resultName: "testGreenResult", image: Image("Runner"), color: Color("Parsley"))
                    
                    ResulltItemButton(title: titles[3], resultName: "testRedResult", image: Image("Meditation"), color: Color("MandarianOrange"))
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
