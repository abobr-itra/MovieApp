import UIKit

class WishlistCoordinator: WishlistCoordinatorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController
    var dependecyManager: DependencyManager

    init(navigationController: UINavigationController, dependecyManager: DependencyManager) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
    }

    func start() {
        let viewModelFabric = WishlistViewModelCreator(coordinator: self, dependencyManager: dependecyManager)
        let viewModel = viewModelFabric.factoryMethod()
        viewModel.loadWishlist() // TODO: ???
        
        let viewController = WishListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // MARK: - WishlistCoordinatorProtocol
    
    func navigateToMovie(_ movieID: String) {
        let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController,
                                                        dependecyManager: dependecyManager,
                                                        movieID: movieID)
        moviePageCoordinator.start()
    }
}
