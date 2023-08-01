import Foundation

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> AuthViewModel {
        let authService = AuthService()
        let viewModel = AuthViewModel(authService: authService)
        return viewModel
    }
}
