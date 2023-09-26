import UIKit

class MoviePageCoordinator: MoviePageCoordiantorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController
    var dependecyManager: DependencyManager
    let movieID: String

    init(navigationController: UINavigationController, dependecyManager: DependencyManager, movieID: String) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
        self.movieID = movieID
    }

    // MARK: - Public

    func start() {
        let viewModelFabric = MoviePageViewModelCreator(dependencyManager: dependecyManager)
        let viewModel = viewModelFabric.factoryMethod()
        viewModel.imdbID = movieID
        let moviePageViewController = MoviePageViewController(viewModel: viewModel)
        navigationController.pushViewController(moviePageViewController, animated: true)
    }
}
