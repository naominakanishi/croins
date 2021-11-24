import Foundation

class UserDefaultsSingleton {
    static var shared = UserDefaultsSingleton()
    
    private init() {}
    
    private let dataInputInKey = "DataInputIn"
    
    private let defaults = UserDefaults.standard
    
    func saveNewInput(_ data: DataInputIn) {
        guard let dataArray = loadDataIn() else {
            defaults.set([data], forKey: dataInputInKey) // Necessário transformar os dados antes de salvar um objeto custom
            return
        }
        defaults.removeObject(forKey: dataInputInKey)
        defaults.set(dataArray, forKey: dataInputInKey)
    }
    
    func loadDataIn() -> [DataInputIn]? {
        defaults.object(forKey: dataInputInKey) as? [DataInputIn]
    }
}
