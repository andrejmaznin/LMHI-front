import Foundation

class HabitsViewModel: ObservableObject {
    @Published var habits: [APIService.Habit]
    @Published var loading: Bool
    
    init() {
        self.habits = []
        self.loading = true
        APIService.getHabits { result in
            switch result {
            case .success(let habits):
                self.habits = habits
                self.loading = false
            case .failure(let error):
                print(error)
//                fatalError("Failed to load habits")
            }
        }
        print(self.habits)
    }
}
