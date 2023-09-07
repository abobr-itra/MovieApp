import UIKit

class CustomFieldView: UIView {
    
    // MARK: - Properties
    
    private var textFieldTopConstraint: NSLayoutConstraint?
    
    private var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var customTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Constants.CustomField .mainColor
        textField.tintColor = Constants.CustomField.mainColor
        return textField
    }()
    
    private var labelTopConstraint: NSLayoutConstraint?
    private var labelLeadingConstraint: NSLayoutConstraint?
    
    private var fieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.CustomField.secondaryColor
        label.font = label.font.withSize(Constants.CustomField.labelDefaultFontSize)
        return label
    }()
    
    private var helperTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.CustomField.secondaryColor
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
        fieldLabel.text = text
    }
    
    func setHelperText(_ text: String) {
        helperTextLabel.text = text
    }
    
    func indecateError() {
        fieldLabel.textColor = Constants.CustomField.errorColor
        bottomBorder?.backgroundColor = Constants.CustomField.errorColor
        helperTextLabel.textColor = Constants.CustomField.errorColor
        customTextField.tintColor = Constants.CustomField.errorColor
    }
    
    func hideError() {
        fieldLabel.textColor = Constants.CustomField.mainColor
        bottomBorder?.backgroundColor = Constants.CustomField.mainColor
        helperTextLabel.textColor = Constants.CustomField.secondaryColor
        customTextField.tintColor = Constants.CustomField.mainColor
    }

    // MARK: - Private

    private func setupView() {
        self.addSubview(textFieldView)
        textFieldView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textFieldView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textFieldView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: self.frame.height - 20).isActive = true
        
        setupBackground()
        setupTextField()
        setupLabel()
        setupHelperText()
    }

    private func setupTextField() {
        textFieldView.addSubview(customTextField)
        customTextField.delegate = self
        let mainParagraphStyle = NSMutableParagraphStyle()
        mainParagraphStyle.lineHeightMultiple = 1.19
        customTextField.attributedText = NSAttributedString(string: "",
                                            attributes: [
                                                NSAttributedString.Key.kern : 0.08,
                                                NSAttributedString.Key.paragraphStyle : mainParagraphStyle
                                            ])
        
        textFieldTopConstraint = customTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        textFieldTopConstraint?.isActive = true
        customTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.CustomField.leadingPadding).isActive = true
        customTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.CustomField.leadingPadding).isActive = true
    }
    
    private func setupLabel() {
        textFieldView.addSubview(fieldLabel)
        makeLabelDefault()
        labelTopConstraint?.isActive = true
        labelLeadingConstraint?.isActive = true
    }
    
    private func makeLabelDefault() {
        UIView.animate(withDuration: 5) {
            self.fieldLabel.font = self.fieldLabel.font.withSize(Constants.CustomField.labelDefaultFontSize)
            self.labelTopConstraint = self.fieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
            self.labelLeadingConstraint = self.fieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.CustomField.leadingPadding)
        }
    }
    
    private func makeLabelSmall() {
        UIView.animate(withDuration: 5) {
            self.fieldLabel.font = self.fieldLabel.font.withSize(Constants.CustomField.labelSmallFontSize)
            self.labelTopConstraint?.constant = 8
        }
    }
    
    private func setupHelperText() {
        self.addSubview(helperTextLabel)
        helperTextLabel.isHidden = true
        helperTextLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        helperTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.CustomField.leadingPadding).isActive = true
    }
    
    private func setupBackground() {
        textFieldView.backgroundColor = Constants.CustomField.backgroundColor
        textFieldView.clipsToBounds = true
        textFieldView.layer.cornerRadius = Constants.CustomField.fielCornerRadius
        textFieldView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomBorder = textFieldView.addBottomBorder(color: Constants.CustomField.mainColor, borderLineSize: 1)
    }
}

extension CustomFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        makeLabelSmall()
        helperTextLabel.isHidden = false
        textFieldTopConstraint?.constant = 20
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField.text ?? "").isEmpty ? makeLabelDefault() : makeLabelSmall()
        helperTextLabel.isHidden = true
        textFieldTopConstraint?.constant = 10
    }
}
