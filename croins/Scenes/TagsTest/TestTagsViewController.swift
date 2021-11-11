import UIKit
import WSTagsField

class teste {
    var categoria: WSTag
    var data: Date
    
    init() { categoria = WSTag("", context: nil) ; data = Date() }
    
    func addCategoria(_ categoria: WSTag) {
        self.categoria = categoria
    }
}

class TestTagsViewController: UIViewController {
    
    let categoriaTeste = teste()
    
    lazy var pageTitle: UILabel = {
        let pageTitle = UILabel()
        pageTitle.text = "Teste Categorias"
        pageTitle.font = UIFont.boldSystemFont(ofSize: 32)
        pageTitle.numberOfLines = 0
        return pageTitle
    }()
    
    lazy var tagsField: WSTagsField = {
        let tagsField = WSTagsField()
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.spaceBetweenLines = 5.0
        tagsField.spaceBetweenTags = 10.0
        tagsField.font = .systemFont(ofSize: 12.0)
        tagsField.backgroundColor = .gray
        tagsField.tintColor = .green
        tagsField.textColor = .black
        tagsField.textColor = .blue
        tagsField.selectedColor = .black
        tagsField.selectedTextColor = .red
        tagsField.isDelimiterVisible = false
        tagsField.placeholderColor = .green
        tagsField.placeholderAlwaysVisible = true
        tagsField.acceptTagOption = .space
        tagsField.shouldTokenizeAfterResigningFirstResponder = true
        tagsField.placeholder = "Categoria"
        tagsField.numberOfLines = 3
        tagsField.enableScrolling = true
        
        // Events
        tagsField.onDidAddTag = { field, tag in
            print("DidAddTag", tag.text)
        }

        tagsField.onDidRemoveTag = { field, tag in
            print("DidRemoveTag", tag.text)
        }

        tagsField.onDidChangeText = { _, text in
            print("DidChangeText")
        }

        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo", height)
        }

        tagsField.onValidateTag = { tag, tags in
            // custom validations, called before tag is added to tags list
            return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
        }
        
        tagsField.onDidSelectTagView = { field, tag in
            let tagText = tagsField.tagViews.filter{ $0 == tag }.first!.displayText
            self.categoriaTeste.addCategoria(tagsField.tags.first(where: { $0.text == tagText })!)
            self.pageTitle.text = self.categoriaTeste.categoria.text
        }

        print("List of Tags Strings:", tagsField.tags.map({$0.text}))
        
        return tagsField
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(pageTitle)
        view.addSubview(tagsField)
    }
    
    func setupConstraints() {
        //MARK: page title constraints
        pageTitle.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
        
        //MARK: tags constraints:
        tagsField.layout {
            $0.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
    }
    
}
