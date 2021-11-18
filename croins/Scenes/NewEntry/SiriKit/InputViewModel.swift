import Foundation
import Intents

class InputViewModel {
    
    private (set) var expensesList: [DataInputIn]
    private (set) var voiceShortcuts: [INVoiceShortcut]
    
    init() { expensesList = []; voiceShortcuts = [] }
    
    func addNewExpense(title: String, value: Double, date: Date) {
        //expensesList.append(DataInputIn(title: title, value: value, date: date))
    }
    
    func getAllShortcuts() {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { shortcuts, error in
            if let shortcuts = shortcuts {
                self.voiceShortcuts = shortcuts
                print(shortcuts)
            } else {
                if let error = error as NSError? {
                    print("Failed to fetch shortcuts with error: \(error)")
                }
            }
        }
    }
}
