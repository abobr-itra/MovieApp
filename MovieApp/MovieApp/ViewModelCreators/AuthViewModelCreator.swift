import Foundation

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod(parser: NetworkPaserProtocol) -> AuthViewModel {
        let authService = AuthService()
        let viewModel = AuthViewModel(authService: authService, coordinator: coordinator)
        return viewModel
    }
}
