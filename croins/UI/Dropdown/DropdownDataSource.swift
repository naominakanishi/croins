import Foundation

protocol DropdownDataSource: AnyObject {
    func stateDidChange()
    func numberOfOptions(_ dropdown: DropdownPicker) -> Int
    func option(_ dropdown: DropdownPicker, at index: IndexPath) -> DropdownOption
}
