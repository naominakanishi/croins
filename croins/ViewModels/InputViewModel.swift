import Foundation
import CoreCroins

class InputViewModel {
    private (set) var incomeList: [DataInputIn]
    private (set) var outcomeList: [DataInputOut]
    
    init() {
        incomeList = AppDatabase.shared.dataInputIns
        outcomeList = AppDatabase.shared.dataInputOuts
    }
    
    func addNewIncome(_ income: DataInputIn) {
        incomeList.append(income)
    }
    
    func addNewOutcome(_ outcome: DataInputOut) {
        outcomeList.append(outcome)
    }
    
    func getRecentTransactions(maxLength: Int) -> [TransactionRecordView.Model] {
        var recentTransactions = [TransactionRecordView.Model]()
        for transaction in incomeList {
            recentTransactions.append(
                TransactionRecordView.Model(
                    isPositive: true,
                    name: transaction.title,
                    category: nil,
                    amount: transaction.value,
                    date: transaction.date))
        }
        for transaction in outcomeList {
            recentTransactions.append(
                TransactionRecordView.Model(
                    isPositive: false,
                    name: transaction.title,
                    category: transaction.category.title,
                    amount: transaction.value,
                    date: transaction.date))
        }
        let maxCount = recentTransactions.count > maxLength ? maxLength : recentTransactions.count
        let result = maxCount > 0 ? Array(recentTransactions[...(maxCount - 1)]) : recentTransactions
        return result
    }
    
    func getMonthlyCharts() -> [BalanceChartView.Bar] {
        var charts = [BalanceChartView.Bar]()
        var filteredTransactionsByMonth = [([DataInputIn], Double, [DataInputOut], Double)]()
        for count in 0..<12 {
            guard let date = Calendar.current.date(byAdding: .month, value: -count, to: Date()) else { return [] }
            filteredTransactionsByMonth.append(
                ((incomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }),
                 incomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }.map({ $0.value }).reduce(0, +),
                 (outcomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }),
                 outcomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }.map({ $0.value }).reduce(0, +))
            )
        }
        guard let highestIncome = filteredTransactionsByMonth.map({ $0.1 }).max() else { return [] }
        guard let highestOutcome = filteredTransactionsByMonth.map({ $0.3 }).max() else { return [] }
        let highestValue = highestIncome > highestOutcome ? highestIncome : highestOutcome
        for month in filteredTransactionsByMonth.filter({ $0.0.count > 0 || $0.2.count > 0 }) {
            let inPercentage =  month.1 / highestValue
            let outPercentage = month.3 / highestValue
            charts.append(BalanceChartView.Bar(
                inPercentage: inPercentage.isNaN ? 0 : inPercentage,
                outPercentage: outPercentage.isNaN ? 0 : outPercentage,
                dateRange: month.0.first?.date.dateRange() ?? month.2.first!.date.dateRange(),
                balance: (month.1 - month.3).currency!,
                balanceColor: .systemOrange,
                isSelected: false,
                date: month.0.first?.date  ?? month.2.first!.date))
        }
        charts.sort{ $0.date < $1.date }
        return charts
    }
    
    func getCurrentBalance() -> String {
        AppDatabase.shared.totalBalance().currency ?? 0.currency ?? ""
    }
}

extension InputViewModel: DatabaseSubscriber {
    func onDatabaseChange() {
        incomeList = AppDatabase.shared.dataInputIns
        outcomeList = AppDatabase.shared.dataInputOuts
    }
}
