import UIKit

class Goal {
    let title: String
    let description: String
    let goal: String
    let initialValue: Double
    let finalDate: Date
    let notifications: Bool
    let notificationPeriod: Int
    
    init(title: String, description: String, goal: String ,initialValue: Double, finalDate: Date, notifications: Bool, notificationPeriod: Int) {
        self.title = title
        self.description = description
        self.goal = goal
        self.initialValue = initialValue
        self.finalDate = finalDate
        self.notifications = notifications
        self.notificationPeriod = notificationPeriod
    }
}
