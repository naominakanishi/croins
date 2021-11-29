import Foundation

protocol CategoryCreator {
    func add(category: Category)
}

protocol DatabaseSubscriber {
    func onDatabaseChange()
}

public final class AppDatabase {
    @AppStorage(key: "categories")
    var categories: [Category]
    
    @AppStorage(key: "DataInputOut")
    var dataInputOuts: [DataInputOut]
    
    @AppStorage(key: "DataInputIn")
    var dataInputIns: [DataInputIn]

    static let shared = AppDatabase()
    
    private init() {}
    
    private var subscribers: [DatabaseSubscriber] = []
    
    func subscribe(_ subscriber: DatabaseSubscriber) {
        subscribers.append(subscriber)
    }
    
    func notify() {
        subscribers.forEach { $0.onDatabaseChange() }
    }
    
    func progress(for category: Category) -> Double {
        (dataInputOuts ?? []).filter( { $0.category == category })
            .map { $0.value }
            .reduce(0, +)
    }
    
    func add(in data: DataInputIn) {
        defer { notify() }
        dataInputIns.append(data)
    }
    
    func add(out data: DataInputOut) {
        defer { notify() }
        dataInputOuts.append(data)
    }
    
    func totalIncome() -> Double {
        dataInputIns.map { $0.value }.reduce(0, +)
    }
    
    func totalOutcome() -> Double {
        dataInputOuts.map { $0.value }.reduce(0, +)
    }
    
    func totalBalance() -> Double {
         totalIncome() - totalOutcome()
    }
}

extension AppDatabase: CategoryCreator {
    func add(category: Category) {
        categories.append(category)
        notify()
    }
}

@propertyWrapper
final class AppStorage<T> where T: Codable, T: Initializable {
    
    private let key: String
    
    init(key: String ) {
        self.key = key
    }
    
    var wrappedValue: T {
        get {
            guard let stored = UserDefaults.standard.data(forKey: key),
                  let decoded = try? JSONDecoder().decode(T.self, from: stored)
            else {
                return T.init()
                
            }
            return decoded
        }
        set {
            guard let encoded = try? JSONEncoder().encode(newValue)
            else { return }
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
}

protocol Initializable {
    init()
}
extension Array: Initializable {}
extension NSArray: Initializable {}
