import Foundation

class AuthViewModelCreator: ViewModelCreatorProtocol {

    typealias ViewModel = AuthViewModel
    
    private unowned let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod(parser: NetworkPaserProtocol) -> AuthViewModel {
        let authService = AuthService()
        let keychainService = KeychainService()
        let analytics = AnalyticsManager(engine: AnalyticsEngine()) // Temporary ???
        let viewModel = AuthViewModel(authService: authService,
                                      keychainService: keychainService,
                                      coordinator: coordinator,
                                      analytics: analytics)
        return viewModel
    }
}
