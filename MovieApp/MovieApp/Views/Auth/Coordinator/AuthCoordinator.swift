import UIKit

class AuthCoordinator: AuthCoordinatorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController
    var dependecyManager: DependencyManager

    init(navigationController: UINavigationController, dependecyManager: DependencyManager) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
    }

    // MARK: - Public

    func start() {
        let viewModelFabric = AuthViewModelCreator(coordinator: self, dependencyManager: dependecyManager)
        let viewModel = viewModelFabric.factoryMethod()

        let viewController = AuthViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

    // MARK: - AuthCoordinatorProtocol

    func navigateToProfile() {
        let viewController = ProfileViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToSettings() {
        navigationController.popViewController(animated: true)
    }
}
