import UIKit

class CustomFieldView: UIView {
    
    var placeholder: String = ""
    
    private struct Constants {
        
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        static let mainColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
    
    private var customTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    // MARK: - Private
    
    private func setupView() {
        setupBackground()
        setupTextField()
    }
    
    private func setupTextField() {
        self.addSubview(customTextField)
        let mainParagraphStyle = NSMutableParagraphStyle()
        mainParagraphStyle.lineHeightMultiple = 1.19
        customTextField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                   attributes: [NSAttributedString.Key.foregroundColor : Constants.mainColor])
        customTextField.tintColor = Constants.mainColor
        customTextField.attributedText = NSAttributedString(string: "",
                                            attributes: [
                                                NSAttributedString.Key.kern : 0.08,
                                                NSAttributedString.Key.paragraphStyle : mainParagraphStyle
                                            ])
        
        customTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        customTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        customTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupBackground() {
        backgroundColor = Constants.backgroundColor
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: bounds.size.height - 1, width: bounds.size.width, height: 1)
        bottomLine.backgroundColor = Constants.mainColor.cgColor
       // borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
