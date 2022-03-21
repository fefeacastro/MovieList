import UIKit

final class ErrorView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.title()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.setTitle(Strings.Errors.tryAgain, for: .normal)
        button.titleLabel?.font = UIFont.medium(weight: .bold)
        button.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        return button
    }()
    
    private let tryAgainAction: (() -> Void)?
    
    // MARK: - Lyfe Cycle
    init(frame: CGRect = .zero, errorMessage: String, tryAgainAction: (() -> Void)?) {
        self.tryAgainAction = tryAgainAction
        super.init(frame: frame)
        descriptionLabel.text = errorMessage
        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: ViewConfiguration {
    // MARK: - View Configuration
    func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(button)
    }
    
    func setupConstraints() {
    }
    
}

private extension ErrorView {
    @objc func tryAgain() {
        tryAgainAction?()
    }
}
