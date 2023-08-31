import UIKit

class FormCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FormCell"
    
    private var formField = CustomFieldView()
    private var textFieldTag: Int?

    // MARK: - Public

    func setup(placeholder: String, helperText: String = "", width: CGFloat, height: CGFloat, tag: Int) {
        formField.setPlaceholder(placeholder)
        formField.setHelperText(helperText)
        textFieldTag = tag
        
        self.addSubview(formField)
        
        formField.translatesAutoresizingMaskIntoConstraints = false
        formField.widthAnchor.constraint(equalToConstant: width).isActive = true
        formField.heightAnchor.constraint(equalToConstant: height).isActive = true

        formField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        formField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.selectionStyle = .none
    }
    
    func focus() {
        formField.becomeFirstResponder()
    }
}

enum TextFieldData: Int {

    case nameField = 0
    case surnameField
    case numberField
}
