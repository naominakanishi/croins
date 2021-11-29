import Foundation

class DataInputIn: Codable {
    let title: String
    let value: Double
    let date: Date
    //let isRecurrent: Bool
    
    init(title: String, value: Double, date: Date)  {
        self.title = title
        self.value = value
        self.date = date
    }
}
