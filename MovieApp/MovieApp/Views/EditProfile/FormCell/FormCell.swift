import UIKit
import Combine

class FormCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FormCell"

    private var formField = CustomFieldView()
    private var viewModel: FormCellViewModel?

    @Published private(set) var text: String = ""
    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Public

    func setup(viewModel: FormCellViewModel, width: CGFloat, height: CGFloat) {
        self.viewModel = viewModel
        
        formField.setPlaceholder(viewModel.placeholder)
        formField.setHelperText(viewModel.helperText)
        formField.setInitialValue(viewModel.text)
        
        self.addSubview(formField)
        observe()
        setupConstraints(height: height, width: width)
        
        self.selectionStyle = .none
    }

    func focus() {
        formField.becomeFirstResponder()
    }
    
    // MARK: - Private
    
    private func observe() {
        formField.$text
            .filter { !$0.isEmpty }
            .sink { self.viewModel?.setData($0) }
            .store(in: &subscriptions)
        viewModel?.$initialValue
            .filter { !$0.isEmpty }
            .sink { self.formField.setInitialValue($0) }
            .store(in: &subscriptions)
    }
    
    private func setupConstraints(height: CGFloat, width: CGFloat) {
        formField.translatesAutoresizingMaskIntoConstraints = false
        formField.widthAnchor.constraint(equalToConstant: width).isActive = true
        formField.heightAnchor.constraint(equalToConstant: height).isActive = true
        formField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        formField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
