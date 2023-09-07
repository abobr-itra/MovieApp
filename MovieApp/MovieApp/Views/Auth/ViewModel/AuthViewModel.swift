import Foundation
import Combine
import Firebase

class AuthViewModel: AuthViewModelProtocol, ObservableObject {
    
    // MARK: - Properties
    
    private let authService: AuthServiceProtocol
    private let keychainService: KeychainServiceProtocol
    private let coordinator: AuthCoordinatorProtocol
    
    private let firebaseService = FirebaseDBService()
    
    @Published private var user: User?
    @Published private var authError: Error?
    
    var email = ""
    var password = ""
    
    // MARK: - Init

    init(authService: AuthServiceProtocol, keychainService: KeychainServiceProtocol, coordinator: AuthCoordinatorProtocol) {
        self.authService = authService
        self.keychainService = keychainService
        self.coordinator = coordinator
    }
    
    // MARK: - Public
    
    func signIn() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signIn(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result: result, authType: .signIn)
        }
    }
    
    func signUp() {
        guard !email.isEmpty && !password.isEmpty else { return }
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            self?.handleAuth(result: result, authType: .signUp)
        }
    }
    
    func signOut() throws {
        try? authService.signOut()
    }
    
    // MARK: - Private
    
    private func handleAuth(result: Result<User, Error>, authType: AuthType) {
        switch result {
        case .success(let user):
            self.user = user
            if authType == .signUp {
                let userModel = UserData(id: user.uid)
                firebaseService.saveData(dataModel: userModel)
            }
            guard let userID = Auth.auth().currentUser?.uid,
                  let userData = userID.data(using: .utf8) else { return }
            keychainService.set(userData, forKey: Constants.KeychainKeys.userID)
            coordinator.navigateToSettings()
        case .failure(let error):
            authError = error
        }
    }
    
    private enum AuthType {
        
        case signIn
        case signUp
    }
}

