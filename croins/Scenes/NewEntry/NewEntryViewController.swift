import UIKit
import DropDown

final class NewEntryViewController: UIViewController, NewEntryViewDelegate {
    
    struct Configuration {
        enum Style {
            case income, outcome
        }
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
    
    /// Populate this array with users category. Whenever categories change, call `newEntryView.reloadCategores()`
    private var categories: [Category] = []
    
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
}

extension NewEntryViewController: DropdownDataSource {
    func stateDidChange() { }
    
    func numberOfOptions(_ dropdown: DropdownPicker) -> Int {
        categories.count
    }
    
    func option(_ dropdown: DropdownPicker, at index: IndexPath) -> DropdownOption {
        let category = categories[index.row]
        return .init(
            name: category.title)
    }
}
