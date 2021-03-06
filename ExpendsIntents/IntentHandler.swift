import Intents
import CoreCroins

class CreateNewExpenseIntentHandler: NSObject, CreateExpenseIntentHandling {
    
    func resolveTitle(for intent: CreateExpenseIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let expenseTitle = intent.title {
            completion(INStringResolutionResult.success(with: expenseTitle))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveValue(for intent: CreateExpenseIntent, with completion: @escaping (CreateExpenseValueResolutionResult) -> Void) {
        if let expenseValue = intent.value {
            completion(CreateExpenseValueResolutionResult.success(with: expenseValue.doubleValue))
        } else {
            completion(CreateExpenseValueResolutionResult.needsValue())
        }
    }
    
    func resolveDate(for intent: CreateExpenseIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
        if let expenseDate = intent.date {
            completion(INDateComponentsResolutionResult.success(with: expenseDate))
        } else {
            completion(INDateComponentsResolutionResult.needsValue())
        }
    }
    
    func confirm(intent: CreateExpenseIntent, completion: @escaping (CreateExpenseIntentResponse) -> Void) {
        completion(CreateExpenseIntentResponse(code: .ready, userActivity: nil))
    }
    
    func handle(intent: CreateExpenseIntent, completion: @escaping (CreateExpenseIntentResponse) -> Void) {
        guard let expenseTitle = intent.title,
              let expenseValue = intent.value,
              let expenseDate = intent.date else {
                  completion(CreateExpenseIntentResponse(code: .failure, userActivity: nil))
                  return
              }
        AppDatabase.shared.add(out: DataInputOut(title: expenseTitle, value: Double(expenseValue), date: expenseDate.date!, category: AppDatabase.shared.categories[0]))
        completion(CreateExpenseIntentResponse.success(result: "successfully"))
    }
    
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is CreateExpenseIntent else {
            fatalError("Unhandled intent")
        }
        return CreateNewExpenseIntentHandler()
    }
    
}
