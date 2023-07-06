import UIKit

class MoviePageCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    let movieID: String
    
    init(navigationController: UINavigationController, movieID: String) {
        self.navigationController = navigationController
        self.movieID = movieID
    }
    
    // MARK: - Public
    
    func start() {
        let viewModelFabric = MoviePageViewModelCreator()
        let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
        
        let moviePageViewController = MoviePageViewController(viewModel: viewModel)
        moviePageViewController.movieID = movieID
        navigationController.pushViewController(moviePageViewController, animated: true)
    }
}
