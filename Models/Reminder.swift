import Foundation
import CoreData

struct Reminder: Identifiable {
    let id: UUID
    var title: String
    var time: Date
    var isCompleted: Bool
    var category: ReminderCategory
    var recurrence: RecurrencePattern?
    var lastCompletedDate: Date?
    var notes: String?
}

enum ReminderCategory: String, CaseIterable {
    case medication = "Medication"
    case water = "Water"
    case exercise = "Exercise"
    case meals = "Meals"
    case custom = "Custom"
    
    var icon: String {
        switch self {
        case .medication: return "pills.fill"
        case .water: return "drop.fill"
        case .exercise: return "figure.walk"
        case .meals: return "fork.knife"
        case .custom: return "bell.fill"
        }
    }
}

enum RecurrencePattern: String {
    case daily = "Daily"
    case weekly = "Weekly"
    case custom = "Custom"
}