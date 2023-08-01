import UIKit
import Combine

class AuthViewController: UIViewController {

    // MARK: - UI Properties
    
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
    
    private var signInButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 145, y: 450, width: 100, height: 35))
        button.setTitle("SignIn", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 145, y: 500, width: 100, height: 35))
        button.setTitle("SignUp", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Properties
    
    private var viewModel: AuthViewModelProtocol?
    private var subscriptions: Set<AnyCancellable> = []

    convenience init(viewModel: AuthViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(self.handleSignIn), for: .touchUpInside)
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(self.handleSignUp), for: .touchUpInside)
        bind()
    }
    
    private func bind() { // TODO: Is this approach effective?
        emailTextField.textPublisher
            .sink { [weak self] email in
                self?.viewModel?.email = email
            }
            .store(in: &subscriptions)
        passwordTextField.textPublisher
            .sink { [weak self] password in
                self?.viewModel?.password = password
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Private
    
    @objc
    private func handleSignIn() {
        viewModel?.signIn()
    }
    
    @objc
    private func handleSignUp() {
        print("SignUp tapped")
        viewModel?.signUp()
    }
}
