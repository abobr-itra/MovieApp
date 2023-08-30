import UIKit

class CustomFieldView: UIView {
    
    // MARK: - Properties
    
    private var textFieldTopConstraint: NSLayoutConstraint?

    private struct Constants {
        
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        static let mainColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        static let secondaryColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        static let errorColor = UIColor(red: 0.69, green: 0, blue: 0.13, alpha: 1)
    }
    
    private var customTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = Constants.mainColor
        return textField
    }()
    
    private var fieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.secondaryColor
        label.font = label.font.withSize(10)
        return label
    }()
    
    private var helperTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.secondaryColor
        label.font = label.font.withSize(10)
        return label
    }()
    
    private var bottomBorder: UIView?

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
    
    func setPlaceholder(_ text: String) {
        customTextField.placeholder = text
        fieldLabel.text = text
    }
    
    func indecateError() {
        fieldLabel.textColor = Constants.errorColor
        bottomBorder?.tintColor = Constants.errorColor
    }

    // MARK: - Private
    
    private func setupView() {
        setupBackground()
        setupTextField()
        setupLabel()
        setupHelperText()
    }
    
    private func setupTextField() {
        self.addSubview(customTextField)
        customTextField.delegate = self
        let mainParagraphStyle = NSMutableParagraphStyle()
        mainParagraphStyle.lineHeightMultiple = 1.19
        customTextField.attributedPlaceholder = NSAttributedString(string: customTextField.placeholder ?? "",
                                                                   attributes: [
                                                                    NSAttributedString.Key.foregroundColor : Constants.secondaryColor
                                                                   ])
        customTextField.tintColor = Constants.mainColor
        customTextField.attributedText = NSAttributedString(string: "",
                                            attributes: [
                                                NSAttributedString.Key.kern : 0.08,
                                                NSAttributedString.Key.paragraphStyle : mainParagraphStyle
                                            ])
        
        textFieldTopConstraint = customTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        textFieldTopConstraint?.isActive = true
        customTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        customTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupLabel() {
        self.addSubview(fieldLabel)
        fieldLabel.isHidden = true
        fieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        fieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    }
    
    private func setupHelperText() {
        self.addSubview(helperTextLabel)
        //helperTextLabel.isHidden = true
        helperTextLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        helperTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupBackground() {
        backgroundColor = Constants.backgroundColor
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomBorder = addBottomBorder(color: Constants.mainColor, borderLineSize: 1)
    }
}

extension CustomFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldLabel.isHidden = false
        textFieldTopConstraint?.constant = 20
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fieldLabel.isHidden = true
        textFieldTopConstraint?.constant = 10
    }
}
