import UIKit
import Combine
import Intents

class InputViewModel: ObservableObject {
    @Published private (set) var dataInputInList: [DataInputIn]
    @Published private (set) var dataInputType: EntryType

    init() {
        dataInputInList = []
        dataInputType = .outcome
    }
    
    func writeIncomeData(title: String, gain: String, method: Method, date: Date, isRecurrent: Bool) {
        dataInputInList.append(DataInputIn(
            title: title,
            gain: gain,
            method: method,
            date: date,
            isRecurrent: isRecurrent))
    }
    
    func setInputType(to entryType: EntryType) {
        dataInputType = entryType
    }
}


