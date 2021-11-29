import UIKit
import Intents
import CoreCroins

final class NewEntryViewController: UIViewController, NewEntryViewDelegate {
    
    var inputViewModel: InputViewModel!

    
    struct Configuration {
        let style: Style
        let onTap: (String, Date, Money, Int?) -> Void
        
        var title: String {
            switch style {
            case .income:
                return "Cadastrar nova entrada"
            case .outcome:
                return "Cadastrar nova saída"
            }
        }
        
        var leadingIcon: UIImage? {
            switch style {
            case .income:
                return UIImage(named: "up-arrow-fill")
            case .outcome:
                return UIImage(named: "down-arrow-fill")
            }
        }
    }
    
    func didTapOnButton(name: String, when: Date, howMuch: Money, categoryIndex: Int?) {
        configuration?.onTap(name, when, howMuch, categoryIndex)
    }
    
    private var newEntryView: NewEntryView? { view as? NewEntryView }
    var configuration: Configuration?
    
    override func loadView() {
        guard let configuration = configuration else {
            return
        }

        view = NewEntryView(
            dropdownDataSource: self,
            delegate: self,
            title: configuration.title,
            headerImage: configuration.leadingIcon,
            isCategoryHidden: configuration.style == .income
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newEntryView?.reloadCategories()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        title = "Registro saída"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func donateInteractionForStyle(_ style: Style) {
        switch style {
        case .income:
            let intent = CreateIncomeIntent()
            intent.suggestedInvocationPhrase = "Add new income"
            intent.title = "New Income"
            intent.value = 0.0
            intent.date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            let interaction = INInteraction(intent: intent, response: nil)
            interaction.donate { (error) in
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        case .outcome:
            let intent = CreateIncomeIntent()
            intent.suggestedInvocationPhrase = "Add new outcome"
            intent.title = "New Outcome"
            intent.value = 0.0
            intent.date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            let interaction = INInteraction(intent: intent, response: nil)
            interaction.donate { (error) in
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }
    
    func newInputAdded(_ name: String, _ when: Date, _ howMuch: Money, _ categoryIndex: Int?) {
        donateInteractionForStyle(configuration!.style)
        switch configuration?.style {
        case .income:
            let newIcome = DataInputIn(title: name, value: howMuch, date: when)
            inputViewModel.addNewIncome(newIcome)
        case .outcome:
            let outcome = DataInputOut(title: name, value: howMuch, date: when, category: AppDatabase.shared.categories[categoryIndex ?? 0])
            inputViewModel.addNewOutcome(outcome)
        default:
            fatalError("Input type not configured")
        }
    }
}

extension NewEntryViewController: DropdownDataSource {
    func stateDidChange() { }
    
    func numberOfOptions(_ dropdown: DropdownPicker) -> Int {
        AppDatabase.shared.categories.count
    }
    
    func option(_ dropdown: DropdownPicker, at index: IndexPath) -> DropdownOption {
        let category = AppDatabase.shared.categories[index.row]
        return .init(
            name: category.title)
    }
}
