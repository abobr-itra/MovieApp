import Foundation

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> AuthViewModel {
        let authService = AuthService()
        let keychainService = KeychainService()
        let viewModel = AuthViewModel(authService: authService, keychainService: keychainService)
        return viewModel
    }
}
