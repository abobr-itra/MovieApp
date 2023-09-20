import Foundation
import Swinject

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    private unowned let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod() -> AuthViewModel {
        let authService = Container.shared.resolve(AuthServiceProtocol.self)!
        let keychainService = Container.shared.resolve(KeychainServiceProtocol.self)!
        let viewModel = AuthViewModel(authService: authService, keychainService: keychainService, coordinator: coordinator)
        return viewModel
    }
}
