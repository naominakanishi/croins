import Foundation

class DataInputIn: Codable {
    let title, gain: String
    //let method: Method
    let date: Date
    //let isRecurrent: Bool
    
    init(title: String, gain: String, date: Date)  {
        self.title = title
        self.gain = gain
        self.date = date
    }
}
