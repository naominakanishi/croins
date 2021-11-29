import Foundation

class DataInputOut {
    let title: String
    let value: Decimal
    let date: Date
    let category: Category
    //let isRecurrent: Bool
    
    init(title: String, value: Decimal, date: Date, category: Category)  {
        self.title = title
        self.value = value
        self.date = date
        self.category = category
    }
}
