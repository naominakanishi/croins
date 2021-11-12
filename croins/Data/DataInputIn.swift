import UIKit
import WSTagsField

class DataInputIn{
    let title: String
    let gain: String
    let method: Method
    let category: WSTag
    let date: Date
    let isRecurrent: Bool

    init(title: String, gain: String, method: Method, category: WSTag, date: Date, isRecurrent: Bool)  {
        self.title = title
        self.gain = gain
        self.method = method
        self.category = category
        self.date = date
        self.isRecurrent = isRecurrent
    }
}


