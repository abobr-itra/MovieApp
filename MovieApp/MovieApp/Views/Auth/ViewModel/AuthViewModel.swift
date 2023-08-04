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
            switch result {
            case .success(let user):
                self?.user = user
                
                guard let currUser = Auth.auth().currentUser,
                      let userData = currUser.uid.data(using: .utf8) else { return }
                if let userEmail = currUser.email {
                    self?.analytics.log(.signIn(email: userEmail))
                }
                self?.keychainService.set(userData, forKey: "user_id")
                self?.coordinator.navigateToSettings()
            case .failure(let error):
                self?.authError = error
            }
        }
    }
    
    func signUp() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                
                guard let currUser = Auth.auth().currentUser,
                      let userData = currUser.uid.data(using: .utf8) else { return }
                if let userEmail = currUser.email {
                    self?.analytics.log(.signUp(email: userEmail))
                }
                self?.keychainService.set(userData, forKey: "user_id")
                self?.coordinator.navigateToSettings()
            case .failure(let error):
                self?.authError = error
            }
        }
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
}
