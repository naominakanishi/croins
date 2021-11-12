import UIKit
import Combine
import WSTagsField

class InputViewModel {
    @Published private (set) var dataInputInList: [DataInputIn]

    init() {
        dataInputInList = []
    }
    
    func writeIncomeData(title: String, gain: String, method: Method, category: WSTag, date: Date, isRecurrent: Bool) {
        dataInputInList.append(DataInputIn(
            title: title,
            gain: gain,
            method: method,
            category: category,
            date: date,
            isRecurrent: isRecurrent))
    }
}


