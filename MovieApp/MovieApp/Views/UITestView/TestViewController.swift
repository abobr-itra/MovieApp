import UIKit

class TestViewController: UIViewController {
    
    private let customTextField: CustomTextField = {
        let textField = CustomTextField(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Label"
        return textField
    }()
    
    private let customTextField2: CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Label"
        return textField
    }()
    
    private let customField: CustomFieldView = {
        let field = CustomFieldView(frame: .zero)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
      //  view.addSubview(customTextField)
        setupView()
//        customTextField2.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        customTextField2.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        customTextField2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        customTextField2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func setupView() {
        view.addSubview(customField)
        customField.placeholder = "Label"
        customField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        customField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        customField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        customField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
