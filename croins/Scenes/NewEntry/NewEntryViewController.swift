import UIKit
import DropDown

final class NewEntryViewController: UIViewController {
    
    private var newEntryView: NewEntryView? { view as? NewEntryView }
    
    /// Populate this array with users category. Whenever categories change, call `newEntryView.reloadCategores()`
    private var categories: [Category] = []
    
    override func loadView() {
        view = NewEntryView(
            dropdownDataSource: self
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
