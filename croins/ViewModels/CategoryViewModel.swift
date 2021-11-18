import Foundation

class CategoryViewModel {
    @Published private (set) var categoryList: [Category]
    
    init() { categoryList = [] }
    
    func addNewCategory(_ category: Category) {
        categoryList.append(category)
    }
}
