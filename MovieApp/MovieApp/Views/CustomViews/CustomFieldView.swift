import UIKit
import Combine

class CustomFieldView: UIView {
    
    // MARK: - Properties
    
    private var textFieldTopConstraint: NSLayoutConstraint?
    var valueChangedHandler: ((_ textField: UITextField) -> ())?

    @Published private(set) var text: String = ""
    private var subscriptions: Set<AnyCancellable> = []

    private struct Constants {
        
        static let fielCornerRadius: CGFloat = 15
        static let leadingPadding: CGFloat = 16
        
        static let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.04)
        static let mainColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        static let secondaryColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        static let errorColor = UIColor(red: 0.69, green: 0, blue: 0.13, alpha: 1)
    }
    
    private var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var customTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Constants.mainColor
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
    
    func setHelperText(_ text: String) {
        helperTextLabel.text = text
    }
    
    func indecateError() {
        fieldLabel.textColor = Constants.errorColor
        bottomBorder?.backgroundColor = Constants.errorColor
        helperTextLabel.textColor = Constants.errorColor
        customTextField.tintColor = Constants.errorColor
    }
    
    func hideError() {
        fieldLabel.textColor = Constants.mainColor
        bottomBorder?.backgroundColor = Constants.mainColor
        helperTextLabel.textColor = Constants.secondaryColor
        customTextField.tintColor = Constants.mainColor
    }

    // MARK: - Private

    private func setupView() {
        self.addSubview(textFieldView)
        textFieldView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textFieldView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textFieldView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: self.frame.height - 20).isActive = true
        
        observe()
        
        setupBackground()
        setupTextField()
        setupLabel()
        setupHelperText()
    }
    
    private func observe() {
        customTextField.textPublisher
            .sink { self.text = $0 }
            .store(in: &subscriptions)
    }

    private func setupTextField() {
        textFieldView.addSubview(customTextField)
        customTextField.delegate = self
        let mainParagraphStyle = NSMutableParagraphStyle()
        mainParagraphStyle.lineHeightMultiple = 1.19
        customTextField.attributedPlaceholder = NSAttributedString(string: customTextField.placeholder ?? "",
                                                                   attributes: [
                                                                    NSAttributedString.Key.foregroundColor : Constants.secondaryColor
                                                                   ])
        customTextField.attributedText = NSAttributedString(string: "",
                                            attributes: [
                                                NSAttributedString.Key.kern : 0.08,
                                                NSAttributedString.Key.paragraphStyle : mainParagraphStyle
                                            ])
        
        textFieldTopConstraint = customTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        textFieldTopConstraint?.isActive = true
        customTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        customTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.leadingPadding).isActive = true
    }
    
    private func setupLabel() {
        textFieldView.addSubview(fieldLabel)
        fieldLabel.isHidden = true
        fieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        fieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    }
    
    private func setupHelperText() {
        self.addSubview(helperTextLabel)
        helperTextLabel.isHidden = true
        helperTextLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        helperTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingPadding).isActive = true
    }
    
    private func setupBackground() {
        textFieldView.backgroundColor = Constants.backgroundColor
        textFieldView.clipsToBounds = true
        textFieldView.layer.cornerRadius = Constants.fielCornerRadius
        textFieldView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomBorder = textFieldView.addBottomBorder(color: Constants.mainColor, borderLineSize: 1)
    }
}

// MARK: - Extensions

extension CustomFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        fieldLabel.isHidden = false
        helperTextLabel.isHidden = false
        textFieldTopConstraint?.constant = 20
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        fieldLabel.isHidden = true
        helperTextLabel.isHidden = true
        textFieldTopConstraint?.constant = 10
        valueChangedHandler?(textField)
    }
}
