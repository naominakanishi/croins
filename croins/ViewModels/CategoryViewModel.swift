import Foundation

class CategoryViewModel {
    private (set) var categoryList: [Category]
    
    init() { categoryList = [Category(title: "Sem Categoria", target: 0, color: .black)] }
    
    func addNewCategory(_ category: Category) {
        categoryList.append(category)
    }
}
