import UIKit

class CustomTextField: UITextField {
    
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
        setupBackground()
        setupTextPadding()
        setupBorder()
        setupPlaceholder()
    }
    
    private func setupTextPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 48))
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
}
