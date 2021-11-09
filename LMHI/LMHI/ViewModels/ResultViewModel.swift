import SwiftUI

class ResultViewModel: ObservableObject {
    enum Section: String {
        case yellow = "Стремления, мотивированные самопониманием"
        case blue = "Эмоциональное отношение к высокозначимым лицам"
        case green = "Характеристика воли и самооценка"
        case red = "Возбудимость и импульсивность"
    }
}
