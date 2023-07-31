import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    
    private var emailTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 350, width: 350, height: 35))
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 400, width: 350, height: 35))
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 145, y: 450, width: 100, height: 35))
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var registerButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 145, y: 500, width: 100, height: 35))
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
}
