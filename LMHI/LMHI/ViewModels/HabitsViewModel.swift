import Foundation

class HabitsViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var values = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let habits = [
        APIService.Habit(
            id: 0,
            name: "Drink your water",
            boolean: false,
            lower: 1200,
            upper: 2500,
            value: "ml"
        ),
        APIService.Habit(
            id: 1,
            name: "Walk outside",
            boolean: false,
            lower: 20,
            upper: 60,
            value: "min"
        ),
        APIService.Habit(
            id: 2,
            name: "Fruits",
            boolean: false,
            lower: 1,
            upper: 4,
            value: "pcs"
        ),
        APIService.Habit(
            id: 3,
            name: "Reading",
            boolean: false,
            lower: 10,
            upper: 100,
            value: "pages"
        ),
        APIService.Habit(
            id: 4,
            name: "Sleep",
            boolean: false,
            lower: 6,
            upper: 9,
            value: "hours"
        ),
        APIService.Habit(
            id: 5,
            name: "Greenery",
            boolean: true,
            lower: 0,
            upper: 1,
            value: nil
        ),
        APIService.Habit(
            id: 6,
            name: "Exercise",
            boolean: false,
            lower: 15,
            upper: 60,
            value: "min"
        ),
        APIService.Habit(
            id: 7,
            name: "Vegetables",
            boolean: false,
            lower: 1,
            upper: 4,
            value: "servings"
        ),
        APIService.Habit(
            id: 8,
            name: "Meditate",
            boolean: false,
            lower: 5,
            upper: 20,
            value: "minutes"
        )
    ]
    
    init() {
        self.values = AppState.load(key: "habits", defaultValue: self.values)
    }
    
    func save() {
        AppState.store(key: "habits", value: values)
    }
}
