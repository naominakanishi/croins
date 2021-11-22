import UIKit

class DataInputIn{
    let title: String
    let gain: String
    let method: Method
    let date: Date
    let isRecurrent: Bool

    init(title: String, gain: String, method: Method, date: Date, isRecurrent: Bool)  {
        self.title = title
        self.gain = gain
        self.method = method
        self.date = date
        self.isRecurrent = isRecurrent
    }
}
