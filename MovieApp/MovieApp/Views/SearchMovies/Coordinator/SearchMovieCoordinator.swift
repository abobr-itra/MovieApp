import UIKit

class SearchMovieCoordinator: SearchMovieCoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    func start() {
        let viewModelFabric = SearchMovieViewModelCreator(coordinator: self)
        let viewModel = viewModelFabric.factoryMethod()
        
        let viewController = SearchMoviesViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Private
    
     func navigateToMovie(_ movieID: String) {
        let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
        moviePageCoordinator.start()
    }
}
