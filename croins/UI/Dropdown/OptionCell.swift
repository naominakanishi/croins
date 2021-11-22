import UIKit

final class OptionCell: UITableViewCell {
    
    enum LayoutMetrics {
        static let horizontalMargins: CGFloat = 10
        static let verticalMargins: CGFloat = 20
    }
    
    let optionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        constraintSubviews()
        configureAdditionalSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        contentView.addSubview(optionNameLabel)
    }
    
    private func constraintSubviews() {
        NSLayoutConstraint.activate([
            optionNameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: LayoutMetrics.verticalMargins
            ),
            optionNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LayoutMetrics.horizontalMargins
            ),
            optionNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -LayoutMetrics.horizontalMargins
            ),
            optionNameLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: 0
            ),
        ])
    }
    
    private func configureAdditionalSettings() {
        backgroundColor = .clear
    }
    
    func configure(using option: DropdownOption) {
        optionNameLabel.text = option.name
    }
}
