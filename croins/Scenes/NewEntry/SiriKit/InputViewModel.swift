import Foundation

class InputViewModel {
    
    private (set) var expensesList: [DataInputIn]
    
    init() { expensesList = [] }
    
    func addNewExpense(title: String, value: Double, date: Date) {
        expensesList.append(DataInputIn(title: title, value: value, date: date))
    }
}
