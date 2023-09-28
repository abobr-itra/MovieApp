import Foundation
import Combine
import Firebase

class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    private let analytics: AnalyticsManager
    private let authService: AuthServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let coordinator: AuthCoordinatorProtocol
    
    private let firebaseService = FirebaseDBService()
    
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
            self?.handleAuth(result, authType: .signIn)
        }
    }
    
    func signUp() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result, authType: .signUp)
        }
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
    
    // MARK: - Private
    

    private func handleAuth(_ result: Result<User, Error>, authType: AuthType) {
        switch result {
        case let .success(user):
            self.user = user
            if authType == .signUp {
                let userModel = UserData(id: user.uid)
                firebaseService.saveData(dataModel: userModel)
            }
            guard let currUser = Auth.auth().currentUser,
                  let userData = currUser.uid.data(using: .utf8) else { return }
            if let userEmail = currUser.email {
                switch authType {
                case .signIn:
                    self.analytics.log(.signIn(email: userEmail))
                case .signUp:
                    self.analytics.log(.signUp(email: userEmail))
                }
            }
            keychainService.set(userData, forKey: Constants.KeychainKeys.userID)
            coordinator.navigateToSettings()
        case .failure(let error):
            self.authError = error
        }
    }
    
    private enum AuthType {
        
        case signIn
        case signUp
    }
}

