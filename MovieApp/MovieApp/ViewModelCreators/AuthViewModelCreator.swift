import Foundation
import Swinject

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    private unowned let coordinator: AuthCoordinatorProtocol
    private var dependencyManager: DependencyManager
    
    init(coordinator: AuthCoordinatorProtocol, dependencyManager: DependencyManager) {
        self.coordinator = coordinator
        self.dependencyManager = dependencyManager
    }

    func factoryMethod() -> AuthViewModel {
        let authService = dependencyManager.resolver.resolve(AuthServiceProtocol.self)!
        let keychainService = dependencyManager.resolver.resolve(KeychainServiceProtocol.self)!
        let analytics = AnalyticsManager(engine: AnalyticsEngine()) // Move to swinject
        let viewModel = AuthViewModel(authService: authService,
                                      keychainService: keychainService,
                                      coordinator: coordinator,
                                      analytics: analytics)
        return viewModel
    }
}
