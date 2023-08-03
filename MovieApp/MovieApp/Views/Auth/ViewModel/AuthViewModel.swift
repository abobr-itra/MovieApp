import Foundation
import Combine
import Firebase

class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    private let authService: AuthServiceProtocol
    private let keychainService: KeychainServiceProtocol
    
    @Published private var user: User?
    @Published private var isAuthSuccess: Bool = false
    @Published private var authError: Error?
    
    var isAuthSuccessPublisher: Published<Bool>.Publisher { $isAuthSuccess }
    
    var email = ""
    var password = ""
    
    // MARK: - Init
    
    init(authService: AuthServiceProtocol, keychainService: KeychainServiceProtocol) {
        self.authService = authService
        self.keychainService = keychainService
    }
    
    // MARK: - Public
    
    func signIn() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signIn(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result: result)
        }
    }
    
    func signUp() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result: result)
        }
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
    
    // MARK: - Private
    
    private func handleAuth(result: (Result<User, Error>)) {
        switch result {
        case .success(let user):
            self.user = user
            
            guard let userID = Auth.auth().currentUser?.uid,
                  let userData = userID.data(using: .utf8) else { return }
            keychainService.set(userData, forKey: "user_id")
            
            isAuthSuccess = true
        case .failure(let error):
            authError = error
        }
    }
}
