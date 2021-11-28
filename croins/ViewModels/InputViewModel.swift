import UIKit
import Combine
import Intents

final class InputViewModel: ObservableObject {
    
    @Published private (set) var dataInputInList: [DataInputIn]
    @Published private (set) var inputModel: InputModel
    
    private (set) var newExpenseDonation = NewExpenseDonation()
    private (set) var newIncomeDonation = NewIncomeDonation()

    init() {
        dataInputInList = []
        inputModel = InputModel(title: "", image: UIImage(), siriIntent: INIntent())
    }
    
    func writeIncomeData(title: String, gain: String, method: Method, date: Date, isRecurrent: Bool) {
        dataInputInList.append(DataInputIn(
            title: title,
            gain: gain,
            date: date))
    }
    
    func setNewInputModel(_ input: InputModel) {
        inputModel = input
    }
}

struct InputModel {
    let title: String
    let image: UIImage
    let siriIntent: INIntent
}

struct NewExpenseDonation {
    let suggestedInvocationPhrase = "Add new expense"
    let title = "newExpense"
    let value = 0.0
    let date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
}

struct NewIncomeDonation {
    let suggestedInvocationPhrase = "Add new income"
    let title = "newIncome"
    let value = 0.0
    let date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
}
