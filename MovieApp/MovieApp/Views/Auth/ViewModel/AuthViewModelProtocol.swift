import Foundation

protocol AuthViewModelProtocol {
    
    var email: String { get set }
    var password: String { get set }
    
    var isAuthSuccessPublisher: Published<Bool>.Publisher { get }
    
    func signIn()
    func signUp()
    func signOut() throws
}
