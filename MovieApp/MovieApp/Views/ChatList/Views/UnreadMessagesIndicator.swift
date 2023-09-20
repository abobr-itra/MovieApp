import UIKit

class UnreadMessagesIndicator: UIView {

    private var numberOfMessagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
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
    }
    
    // MARK: - Private
    
    private func setupView() {
        self.addSubview(numberOfMessagesLabel)
        
        NSLayoutConstraint.activate([
            numberOfMessagesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            numberOfMessagesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            numberOfMessagesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            numberOfMessagesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
        ])
        
        self.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    
        self.layer.cornerRadius = self.frame.width / 2
        
    }
}
