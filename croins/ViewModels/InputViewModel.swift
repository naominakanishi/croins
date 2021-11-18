import UIKit
import Combine
import Intents

class InputViewModel {
    @Published private (set) var dataInputInList: [DataInputIn]
    @Published private (set) var shortcutList: [INVoiceShortcut]

    init() {
        dataInputInList = []
        shortcutList = []
    }
    
    func writeIncomeData(title: String, gain: String, method: Method, date: Date, isRecurrent: Bool) {
        dataInputInList.append(DataInputIn(
            title: title,
            gain: gain,
            method: method,
            date: date,
            isRecurrent: isRecurrent))
    }
    
    func getAllShortcuts() {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { shortcurts, error in
            if let shortcurts = shortcurts {
                self.shortcutList = shortcurts
            }
        }
    }
}


