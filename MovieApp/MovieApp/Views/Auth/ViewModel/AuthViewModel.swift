import Foundation
import Combine
import Firebase

class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    private let analytics: AnalyticsManager
    private let authService: AuthServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let coordinator: AuthCoordinatorProtocol
    
    @Published private var user: User?
    @Published private var authError: Error?
    
    var email = ""
    var password = ""
    
    // MARK: - Init

    init(authService: AuthServiceProtocol,
         keychainService: KeychainServiceProtocol,
         coordinator: AuthCoordinatorProtocol,
         analytics: AnalyticsManager) {
        self.authService = authService
        self.keychainService = keychainService
        self.coordinator = coordinator
        self.analytics = analytics
    }
    
    // MARK: - Public
    
    func signIn() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signIn(withEmail: email, password: password) { [weak self] result in
            self?.hadleResult(result, resultType: .signIn)
        }
    }
    
    func signUp() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            self?.hadleResult(result, resultType: .signUp)
        }
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
    
    // MARK: - Private
    
    private enum ResultType {
        
        case signIn
        case signUp
    }
    
    private func hadleResult(_ result: Result<User, Error>, resultType: ResultType) {
        switch result {
        case let .success(user):
            self.user = user
            
            guard let currUser = Auth.auth().currentUser,
                  let userData = currUser.uid.data(using: .utf8) else { return }
            if let userEmail = currUser.email {
                switch resultType {
                case .signIn:
                    self.analytics.log(.signIn(email: userEmail))
                case .signUp:
                    self.analytics.log(.signUp(email: userEmail))
                }
            }
            self.keychainService.set(userData, forKey: "user_id")
            self.coordinator.navigateToSettings()
        case let .failure(error):
            self.authError = error
        }
    }
}
