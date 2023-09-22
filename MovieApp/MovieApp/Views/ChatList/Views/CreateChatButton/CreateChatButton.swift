import UIKit

class CreateChatButton: UIButton {
    
    // MARK: - Properties
    
    private var createImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "create_chat")
        return imageView
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        self.addSubview(createImage)
        NSLayoutConstraint.activate([
            createImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 56),
            self.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        self.backgroundColor = UIColor(red: 0.18, green: 0.5, blue: 0.93, alpha: 1)
        self.layer.cornerRadius = 28
    }
}
