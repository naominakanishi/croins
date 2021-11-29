import Foundation

public protocol CategoryCreator {
    func add(category: Category)
}

public protocol DatabaseSubscriber {
    func onDatabaseChange()
}

public final class AppDatabase {
    @AppStorage(key: "categories")
    public var categories: [Category]
    
    @AppStorage(key: "DataInputOut")
    public var dataInputOuts: [DataInputOut]
    
    @AppStorage(key: "DataInputIn")
    public var dataInputIns: [DataInputIn]

    public static let shared = AppDatabase()
    
    private init() {}
    
    private var subscribers: [DatabaseSubscriber] = []
    
    public func subscribe(_ subscriber: DatabaseSubscriber) {
        subscribers.append(subscriber)
    }
    
    func notify() {
        subscribers.forEach { $0.onDatabaseChange() }
    }
    
    public func progress(for category: Category) -> Double {
        (dataInputOuts ?? []).filter( { $0.category == category })
            .map { $0.value }
            .reduce(0, +)
    }
    
    public func add(in data: DataInputIn) {
        defer { notify() }
        dataInputIns.append(data)
    }
    
    public func add(out data: DataInputOut) {
        defer { notify() }
        dataInputOuts.append(data)
    }
    
    public func totalIncome() -> Double {
        dataInputIns.map { $0.value }.reduce(0, +)
    }
    
    public func totalOutcome() -> Double {
        dataInputOuts.map { $0.value }.reduce(0, +)
    }
    
    public func totalBalance() -> Double {
         totalIncome() - totalOutcome()
    }
}

extension AppDatabase: CategoryCreator {
    public func add(category: Category) {
        categories.append(category)
        notify()
    }
}

@propertyWrapper
public final class AppStorage<T> where T: Codable, T: Initializable {
    
    private let key: String
    
    init(key: String ) {
        self.key = key
    }
    
    public var wrappedValue: T {
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

public protocol Initializable {
    init()
}
extension Array: Initializable {}
extension NSArray: Initializable {}
