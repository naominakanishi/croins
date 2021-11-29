import Foundation

public class DataInputIn: Codable {
    public let title: String
    public let value: Double
    public let date: Date
    //let isRecurrent: Bool
    
    public init(title: String, value: Double, date: Date)  {
        self.title = title
        self.value = value
        self.date = date
    }
}
