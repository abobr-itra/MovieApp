import UIKit

class EditProfileCoordinator: EditProfileCoordinatorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController
    var dependecyManager: DependencyManager

    // MARK: - Init

    init(navigationController: UINavigationController, dependecyManager: DependencyManager) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
    }

    func start() {
        let viewModelCreator = EditProfileViewModelCreator(coordinator: self, dependencyManager: dependecyManager)
        let viewModel = viewModelCreator.factoryMethod()
        let viewController = EditProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
