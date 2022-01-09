import SwiftUI

struct TestResultsView: View {
    var spacing: CGFloat = 20.0
    var titles = [
        "Стремления, мотивированные самопониманием",
        "Эмоциональное отношение к высокозначимым лицам",
        "Характеристика воли и самооценка",
        "Возбудимость и импульсивность",
        "Ожидания и отношение к окружению"
    ]
    var results: [String?]
    
    var body: some View {
        VStack {
            VStack(spacing: spacing) {
                ResulltItemButton(title: titles[0], interpretation: results[0], image: Image("Books"), color: Color("GovernorBay"))
                
                ResulltItemButton(title: titles[1], interpretation: results[1], image: Image("Family"), color: Color("DarkestBlue"))
                
                ResulltItemButton(title: titles[2], interpretation: results[2], image: Image("Runner"), color: Color("Parsley"))
                
                ResulltItemButton(title: titles[3], interpretation: results[3], image: Image("Meditation"), color: Color("MandarianOrange"))
                
                ResulltItemButton(title: titles[4], interpretation: results[4], image: Image("People"), color: Color("Highball"))
            }
        }
        .padding()
        .navigationTitle("Результаты")
    }
}

struct TestResultsView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultsView(results: ["Test", "Test", "Test", "Test", "Test"])
    }
}
