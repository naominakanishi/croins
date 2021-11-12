import UIKit
import Combine

class InputViewModel {
    @Published var dataInputInList: [DataInputIn]

    init() {
        dataInputInList = []
    }
}


