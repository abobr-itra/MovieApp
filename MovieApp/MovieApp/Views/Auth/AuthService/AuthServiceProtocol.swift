import Foundation
import Firebase

protocol AuthServiceProtocol {
    
    var currentUser: User? { get }
    
    func signUp(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func signOut() throws
}
