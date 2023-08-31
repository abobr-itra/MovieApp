import UIKit

class EditProfileCoordinator: CoordinatorProtocol {

    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = EditProfileViewController(viewModel: EditProfileViewModel())
        navigationController.pushViewController(viewModel, animated: true)
    }
}
