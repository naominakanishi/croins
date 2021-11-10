import UIKit

class NewEntryViewController: UIViewController {
    
    let pageTitle = UILabel()
    let pageContent = UILabel()
    
    let spentMoneyButton = UIButton()
    let receivedMoneyButton = UIButton()
    
       
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageTitle()
        view.backgroundColor = .white
    }
    
    func setupPageTitle(){
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageTitle)
        
        pageTitle.text = "Vamos lá"
        pageTitle.font = UIFont.boldSystemFont(ofSize: 32)
        pageTitle.numberOfLines = 0
        
        pageTitle.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        }
    }
    
    func setupConstraints() {
        //MARK: page title constraints
        
    }
    
}
