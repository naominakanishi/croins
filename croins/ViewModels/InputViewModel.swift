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
    
    func getRecentTransactions() -> [TransactionRecordView.Model] {
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
        return recentTransactions
    }
    
    func getMonthlyCharts() -> [BalanceChartView.Bar] {
        var charts = [BalanceChartView.Bar]()
        var filteredTransactionsByMotnh = [([DataInputIn], Decimal, [DataInputOut], Decimal)]()
        for count in 0..<12 {
            guard let date = Calendar.current.date(byAdding: .month, value: -count, to: Date()) else { return [] }
            filteredTransactionsByMotnh.append(
                ((incomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }),
                 incomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }.map({ $0.value }).reduce(0, +),
                 (outcomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }),
                 outcomeList.filter{ $0.date.isInSameMonthAndYear(as: date) }.map({ $0.value }).reduce(0, +))
            )
        }
        guard let highestIncome = filteredTransactionsByMotnh.map({ $0.1 }).max() else { return [] }
        guard let highestOutcome = filteredTransactionsByMotnh.map({ $0.3 }).max() else { return [] }
        for month in filteredTransactionsByMotnh.filter({ $0.0.count > 0 || $0.2.count > 0 }) {
            let inPercentage = NSDecimalNumber(decimal: month.1 / highestIncome).doubleValue
            let outPercentage = NSDecimalNumber(decimal: month.3 / highestOutcome).doubleValue
            charts.append(BalanceChartView.Bar(
                inPercentage: inPercentage.isNaN ? 0 : inPercentage,
                outPercentage: outPercentage.isNaN ? 0 : outPercentage,
                dateRange: month.0.first?.date.dateRange() ?? month.2.first!.date.dateRange(),
                balance: NSDecimalNumber(decimal: month.1 - month.3).stringValue,
                balanceColor: .systemOrange,
                isSelected: false,
                date: month.0.first?.date  ?? month.2.first!.date))
        }
        charts.sort{ $0.date < $1.date }
        return charts
    }
}
