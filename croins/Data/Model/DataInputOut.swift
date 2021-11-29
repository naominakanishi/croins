import Foundation

public class DataInputOut: Codable {
    public let title: String
    public let value: Double
    public let date: Date
    public let category: Category
    //let isRecurrent: Bool
    
    public init(title: String, value: Double, date: Date, category: Category)  {
        self.title = title
        self.value = value
        self.date = date
        self.category = category
    }
}
