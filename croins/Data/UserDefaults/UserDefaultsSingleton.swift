import Foundation
import CoreCroins

class UserDefaultsSingleton {
    static var shared = UserDefaultsSingleton()
    
    private init() {}
    
    private let dataInputInKey = "DataInputIn"
    
    private let defaults = UserDefaults.standard
    
    func saveNewInput(_ data: DataInputIn) {
        guard var dataArray = loadDataIn() else {
            do {
                try defaults.setNewObject([data], forKey: dataInputInKey)
            } catch {
                print(error.localizedDescription)
            }
            return
        }
        defaults.removeObject(forKey: dataInputInKey)
        dataArray.append(data)
        do {
            try defaults.setNewObject(dataArray, forKey: dataInputInKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadDataIn() -> [DataInputIn]? {
        do {
            return try defaults.getOldObject(forKey: dataInputInKey, castTo: [DataInputIn].self)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
