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
        var filteredTransactionsByMonth = [([DataInputIn], Decimal, [DataInputOut], Decimal)]()
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
            let inPercentage = NSDecimalNumber(decimal: month.1 / highestValue).doubleValue
            let outPercentage = NSDecimalNumber(decimal: month.3 / highestValue).doubleValue
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
    
    func getCurrentBalance() -> String {
        let intMoney = NSDecimalNumber(decimal: (incomeList.map{ $0.value }.reduce(0, +) - outcomeList.map{ $0.value }.reduce(0, +)) * 100).intValue
        let resultMoney = Money(intMoney) / 100
        return resultMoney.currency ?? "R$ 0,00"
    }
}
