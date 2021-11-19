import Intents

class CreateNewIncomeIntentHandler: NSObject, CreateIncomeIntentHandling {
    
    func resolveTitle(for intent: CreateIncomeIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let incomeTitle = intent.title {
            completion(INStringResolutionResult.success(with: incomeTitle))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveValue(for intent: CreateIncomeIntent, with completion: @escaping (CreateIncomeValueResolutionResult) -> Void) {
        if let incomeValue = intent.value {
            completion(CreateIncomeValueResolutionResult.success(with: incomeValue.doubleValue))
        } else {
            completion(CreateIncomeValueResolutionResult.needsValue())
        }
    }
    
    func resolveDate(for intent: CreateIncomeIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
        if let incomeDate = intent.date {
            completion(INDateComponentsResolutionResult.success(with: incomeDate))
        } else {
            completion(INDateComponentsResolutionResult.needsValue())
        }
    }
    
    func handle(intent: CreateIncomeIntent, completion: @escaping (CreateIncomeIntentResponse) -> Void) {
        guard let incomeTitle = intent.title,
              let incomeValue = intent.value,
              let incomeDate = intent.date else {
                  completion(CreateIncomeIntentResponse(code: .failure, userActivity: nil))
                  return
              }
        print("\(incomeTitle), \(incomeValue), \(String(describing: incomeDate.date))")
        completion(CreateIncomeIntentResponse.success(result: "succesfully"))
    }
    
}

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is CreateIncomeIntent else {
            fatalError("Unhandled intent")
        }
        return CreateNewIncomeIntentHandler()
    }
    
}
