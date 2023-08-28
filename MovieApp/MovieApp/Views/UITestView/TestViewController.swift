import UIKit

class TestViewController: UIViewController {
    
    private let customTextField: CustomTextField = {
        let textField = CustomTextField(frame: CGRect(x: 100, y: 100, width: 200, height: 48))
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(customTextField)
//        customTextField2.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        customTextField2.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        customTextField2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        customTextField2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
