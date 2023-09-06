import Foundation
import Firebase

class AuthService: AuthServiceProtocol {
    
    // MARK: - Public
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    func signUp(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            self?.handleAuth(authResult: authResult, error: error, completion: completion)
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.handleAuth(authResult: authResult, error: error, completion: completion)
        }
    }
    
    func signOut() throws {
        try? Auth.auth().signOut()
    }
    
    // MARK: - Private
    
    private func handleAuth(authResult: AuthDataResult?, error: Error?, completion: @escaping (Result<User, Error>) -> Void) {
        if let error = error {
            print("Error \(error)")
            completion(.failure(error))
        } else if let user = authResult?.user {
            print("User \(user)")
            completion(.success(user))
        } else {
            completion(.failure(AuthError.failedToAuthorize))
        }
    }
}
