import UIKit
import Combine

class FormCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FormCell"
    
    private var formField = CustomFieldView()
    private var textFieldTag: Int?
    @Published private(set) var text: String = ""
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Public

    func setup(placeholder: String, helperText: String = "", width: CGFloat, height: CGFloat, tag: Int, initialValue: String = "") {
        formField.setPlaceholder(placeholder)
        formField.setHelperText(helperText)
        formField.setInitialValue(initialValue)
        textFieldTag = tag
        
        self.addSubview(formField)
        observe()
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
    
    // MARK: - Private
    
    private func observe() {
        formField.$text
            .sink {
                self.text = $0
            }
            .store(in: &subscriptions)
    }
}
