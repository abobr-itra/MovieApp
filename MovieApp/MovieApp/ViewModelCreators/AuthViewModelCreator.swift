import Foundation

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod(parser: NetworkPaserProtocol) -> AuthViewModel {
        let authService = AuthService()
        let keychainService = KeychainService()
        let viewModel = AuthViewModel(authService: authService, keychainService: keychainService, coordinator: coordinator)
        return viewModel
    }
}
