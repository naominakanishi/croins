import Foundation

extension Date {
    private func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
            calendar.isDate(self, equalTo: date, toGranularity: component)
        }
    
    private func startOfMonth() -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    private func endOfMonth() -> Date {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func isInSameMonthAndYear(as date: Date) -> Bool {
        isEqual(to: date, toGranularity: .month) && isEqual(to: date, toGranularity: .year)
    }
    
    func dateRange() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return String(format: "%@-%@", formatter.string(from: self.startOfMonth()), formatter.string(from: self.endOfMonth()))
    }
}
