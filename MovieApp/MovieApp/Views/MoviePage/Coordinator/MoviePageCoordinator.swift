import UIKit

class MoviePageCoordinator: MoviePageCoordiantorProtocol {
    
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
        viewModel.imdbID = movieID
        let moviePageViewController = MoviePageViewController(viewModel: viewModel)
        navigationController.pushViewController(moviePageViewController, animated: true)
    }
}
