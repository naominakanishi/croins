import Foundation

class DataInputOut: Codable {
    let title: String
    let value: Double
    let date: Date
    let category: Category
    //let isRecurrent: Bool
    
    init(title: String, value: Double, date: Date, category: Category)  {
        self.title = title
        self.value = value
        self.date = date
        self.category = category
    }
}
