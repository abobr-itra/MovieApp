import UIKit

class UnreadMessagesIndicator: UIView {

    private var numberOfMessagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.plusJakartBold
        label.textColor = .white
        return label
    }()

    private enum LocalConstants {

        static let verticalSpacing: CGFloat = 8
        static let horizontalSpacing: CGFloat = 4
        static let viewHeight: CGFloat = 26
    }

    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    // MARK: - Public

    func setNumber(_ number: Int) {
        numberOfMessagesLabel.text = String(number)
        self.setNeedsLayout()
    }

    // MARK: - Private

    private func setupView() {
        self.addSubview(numberOfMessagesLabel)

        NSLayoutConstraint.activate([
            numberOfMessagesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LocalConstants.verticalSpacing),
            numberOfMessagesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LocalConstants.verticalSpacing),
            numberOfMessagesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: LocalConstants.horizontalSpacing),
            numberOfMessagesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -LocalConstants.horizontalSpacing),
        ])

        self.backgroundColor = UIColor(red: 0.18, green: 0.5, blue: 0.93, alpha: 1)
        self.widthAnchor.constraint(equalToConstant: LocalConstants.viewHeight).isActive = true
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.layer.cornerRadius = LocalConstants.viewHeight / 2

        self.setNeedsLayout()
    }
}
