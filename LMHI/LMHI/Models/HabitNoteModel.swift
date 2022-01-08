import Foundation

struct HabitNoteModel: Encodable {
    struct HabitNote: Encodable {
        let habit_id: Int
        let value: Int
    }
    
    let habit_note: HabitNote
    
    init(id: Int, _ value: Int) {
        self.habit_note = HabitNote(habit_id: id, value: value)
    }
}
