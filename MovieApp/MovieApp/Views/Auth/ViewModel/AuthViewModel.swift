import Foundation
import Combine
import Firebase

class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    private let authService: AuthServiceProtocol
    private let coordinator: AuthCoordinatorProtocol
    
    @Published private var user: User?
    @Published private var authError: Error?
    
    var email = ""
    var password = ""
    
    // MARK: - Init
    
    init(authService: AuthServiceProtocol, coordinator: AuthCoordinatorProtocol) {
        self.authService = authService
        self.coordinator = coordinator
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
            coordinator.navigateToSettings()
        case .failure(let error):
            authError = error
        }
    }
}
