import UIKit

class WishlistCoordinator: WishlistCoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModelFabric = WishlistViewModelCreator(coordinator: self)
        let viewModel = viewModelFabric.factoryMethod()
        viewModel.loadWishlist() // TODO: ???
        
        let viewController = WishListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // MARK: - WishlistCoordinatorProtocol
    
    func navigateToMovie(_ movieID: String) {
        let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
        moviePageCoordinator.start()
    }
}
