import SwiftUI

struct MoodDiary: View {
    let spacing: CGFloat = 20.0
    let aspectRatio: CGFloat = 3.15
    let moodCriterias: [String]
    
    @State var selection: Int = 0
    @State var currentCriteria: Int = 0
    
    @GestureState var offset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            HStack(spacing: spacing) {
                ForEach(0..<moodCriterias.count, id: \.self) { id in
                    Picker(title: moodCriterias[id], currentSelection: $selection)
                        .frame(width: width - 2.0 * spacing)
                }
            }
            .padding(.horizontal, spacing)
//            .offset(x: CGFloat(currentCriteria) * -width + offset)
//            .gesture(
//                DragGesture()
//                    .updating($offset) { value, out, _ in
//                        out = value.translation.width
//                    }
//                    .onEnded { value in
//                        let offsetX = value.translation.width
//                        if offsetX >= width / 2.0 {
//                            currentCriteria += 1
//                        }
//                    }
//            )
//        }
        .animation(.easeInOut, value: offset == 0)
    }
}

struct MoodDiary_Previews: PreviewProvider {
    static var previews: some View {
        MoodDiary(moodCriterias: ["Мотивация", "Агрессия", "Плохие моменты"])
    }
}
