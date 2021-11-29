import Foundation

class InputViewModel {
    private (set) var incomeList: [DataInputIn]
    private (set) var outcomeList: [DataInputOut]
    
    init() {
        incomeList = []
        outcomeList = []
    }
    
    func addNewIncome(_ income: DataInputIn) {
        incomeList.append(income)
    }
    
    func addNewOutcome(_ outcome: DataInputOut) {
        outcomeList.append(outcome)
    }
}
