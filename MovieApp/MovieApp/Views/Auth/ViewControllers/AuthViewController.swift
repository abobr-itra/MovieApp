import UIKit
import Combine

class AuthViewController: UIViewController {

    // MARK: - UI Properties
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignIn", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignUp", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Properties

    private var viewModel: AuthViewModelProtocol?
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Init

    convenience init(viewModel: AuthViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupTextFields([emailTextField, passwordTextField], basicMargin: 300)
        setupButtons()
    }

    private func setupTextFields(_ textFields: [UITextField], basicMargin: CGFloat, gap: CGFloat = 50.0) {
        for (index, textField) in textFields.enumerated() {
            view.addSubview(textField)
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: basicMargin + (gap * CGFloat(index))),
                textField.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: Constants.TextFields.sideMargin),
                textField.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -Constants.TextFields.sideMargin)
            ])
        }
    }
    
    private func setupButtons(_ buttons: [UIButton], basicMargin: CGFloat, gap: CGFloat = 50.0) {
        for (index, button) in buttons.enumerated() {
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: basicMargin + (gap * CGFloat(index))),
                button.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: Constants.TextFields.buttonsSideMargin),
                button.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -Constants.TextFields.buttonsSideMargin)
            ])
        }
    }
    
    private func setupButtons() {
        
        setupButtons([signInButton, signUpButton], basicMargin: 400)

        signInButton.addTarget(self, action: #selector(self.handleSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(self.handleSignUp), for: .touchUpInside)
    }
    
    private func bind() {
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
    
    @objc
    private func handleSignIn() {
        viewModel?.signIn()
    }
    
    @objc
    private func handleSignUp() {
        viewModel?.signUp()
    }    
}
