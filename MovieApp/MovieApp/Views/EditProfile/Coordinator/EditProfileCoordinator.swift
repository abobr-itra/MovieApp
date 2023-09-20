import UIKit

class EditProfileCoordinator: EditProfileCoordinatorProtocol {

    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModelCreator = EditProfileViewModelCreator(coordinator: self)
        let viewModel = viewModelCreator.factoryMethod()
        let viewController = EditProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
