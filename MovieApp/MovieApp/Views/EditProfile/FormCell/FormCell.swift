import UIKit

class FormCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FormCell"
    
    private var formField = CustomFieldView()

    // MARK: - Public
    
    func setup(placeholder: String, helperText: String = "", width: CGFloat, height: CGFloat) {
        formField.setPlaceholder(placeholder)
        formField.setHelperText(helperText)
        
        formField.translatesAutoresizingMaskIntoConstraints = false
        formField.widthAnchor.constraint(equalToConstant: width).isActive = true
        formField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        formField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        formField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        formField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        formField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
