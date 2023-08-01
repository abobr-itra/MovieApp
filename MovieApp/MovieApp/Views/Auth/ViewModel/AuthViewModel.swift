import Foundation
import Combine
import Firebase

class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    private let authService: AuthServiceProtocol
    
    @Published private var user: User?
    @Published private var authError: Error?
    
    var email = ""
    var password = ""
    
    // MARK: - Init
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    // MARK: - Public
    
    func signIn() {
        guard !email.isEmpty && !password.isEmpty else { return }
        print("SignIn Email: \(email) Password: \(password)")
        authService.signIn(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result: result)
        }
    }
    
    func signUp() {
        guard !email.isEmpty && !password.isEmpty else { return }
        print("SignUp Email: \(email) Password: \(password)")
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result: result)
        }
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
    
    // MARK: - Private
    
    private func handleAuth(result: (Result<User, Error>)) {
        print("Result: \(result)")
        switch result {
        case .success(let user):
            self.user = user
        case .failure(let error):
            authError = error
        }
    }
}
