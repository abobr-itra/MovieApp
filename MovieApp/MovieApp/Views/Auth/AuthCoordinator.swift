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
        
        navigationController.pushViewController(viewController, animated: false)
    }
}
