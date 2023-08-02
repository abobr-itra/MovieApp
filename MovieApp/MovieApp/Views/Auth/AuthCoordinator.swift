import UIKit

class AuthCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    func start() {
        let viewModelFabric = AuthViewModelCreator()
        let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
        
        let viewController = AuthViewController(viewModel: viewModel)
        viewController.actions = .init(authenticate: navigateToSettings)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Private
    
    private func authenticate() {
        let viewController = ProfileViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToSettings() {
        navigationController.popViewController(animated: true)
    }
}
