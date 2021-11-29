import Foundation

protocol CategoryCreator {
    func add(category: Category)
}

protocol DatabaseSubscriber {
    func onDatabaseChange()
}

final class AppDatabase {
    @AppStorage(key: "categories")
    var categories: [Category]?
    
    @AppStorage(key: "DataInputOut")
    var dataInputOuts: [DataInputOut]?
    
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
}

extension AppDatabase: CategoryCreator {
    func add(category: Category) {
        categories?.append(category)
        notify()
    }
}

@propertyWrapper
final class AppStorage<T> where T: Codable {
    
    private let key: String
    
    init(key: String ) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            guard let stored = UserDefaults.standard.data(forKey: key),
                  let decoded = try? JSONDecoder().decode(T.self, from: stored)
            else { return nil }
            return decoded
        }
        set {
            guard let encoded = try? JSONEncoder().encode(newValue)
            else { return }
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
}
