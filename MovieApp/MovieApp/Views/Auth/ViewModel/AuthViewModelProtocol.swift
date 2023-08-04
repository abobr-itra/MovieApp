import Foundation

protocol AuthViewModelProtocol {
    
    var email: String { get set }
    var password: String { get set }

    func signIn()
    func signUp()
    func signOut() throws
}
