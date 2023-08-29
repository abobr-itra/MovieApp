import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {
    
    private let labelView = UILabel()
    
    private struct Constants {
        
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        static let mainColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        delegate = self
        setupBackground()
        setupTextPadding()
        setupLabel()
        setupBorder()
        setupPlaceholder()
    }
    
    private func setupLabel() {
        font = UIFont(name: "Roboto-Regular", size: 16)
        let mainParagraphStyle = NSMutableParagraphStyle()
        mainParagraphStyle.lineHeightMultiple = 1.19
        attributedText = NSAttributedString(string: "",
                                            attributes: [
                                                NSAttributedString.Key.kern : 0.08,
                                                NSAttributedString.Key.paragraphStyle : mainParagraphStyle
                                            ])
        
        
        labelView.isHidden = true
        labelView.frame = CGRect(x: 16, y: 8, width: 50, height: 5)
        labelView.text = "placeholder"
        labelView.tintColor = Constants.mainColor
        labelView.font = UIFont(name: "Roboto-Regular", size: 5)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.02
//        labelView.attributedText = NSAttributedString(string: "",
//                                            attributes: [
//                                                NSAttributedString.Key.kern : 0.15,
//                                                NSAttributedString.Key.paragraphStyle : paragraphStyle
//                                            ])

        self.addSubview(labelView)
    }
    
    private func setupTextPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: bounds.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    private func setupBorder() {
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1)
        bottomLine.backgroundColor = Constants.mainColor.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
    
    private func setupPlaceholder() {
        attributedPlaceholder = NSAttributedString(string: "Placeholder",
                                                   attributes: [NSAttributedString.Key.foregroundColor : Constants.mainColor])
    }
    
    private func setupBackground() {
        backgroundColor = Constants.backgroundColor
        tintColor = Constants.mainColor
        
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        layoutSubviews()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Here🤡")
        self.contentVerticalAlignment = .bottom
        labelView.isHidden = false
    }
}
