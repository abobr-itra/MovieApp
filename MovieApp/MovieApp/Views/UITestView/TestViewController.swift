import UIKit

class TestViewController: UIViewController {

    private let customField: CustomFieldView = {
        let field = CustomFieldView(frame: .zero)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(customField)
        customField.setPlaceholder("Label")
        customField.setHelperText("Helper text")
      //  customField.indecateError()
        customField.heightAnchor.constraint(equalToConstant: 68).isActive = true
        customField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
