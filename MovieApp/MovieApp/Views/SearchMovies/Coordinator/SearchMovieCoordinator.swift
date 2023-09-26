import UIKit

class SearchMovieCoordinator: SearchMovieCoordinatorProtocol {

    // MARK: - Properties

    var navigationController: UINavigationController
    var dependecyManager: DependencyManager

    init(navigationController: UINavigationController, dependecyManager: DependencyManager) {
        self.navigationController = navigationController
        self.dependecyManager = dependecyManager
    }

    // MARK: - Public

    func start() {
        let viewModelFabric = SearchMovieViewModelCreator(coordinator: self, dependencyManager: dependecyManager)
        let viewModel = viewModelFabric.factoryMethod()

        let viewController = SearchMoviesViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: false)
    }

    // MARK: - Private

     func navigateToMovie(_ movieID: String) {
         let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController,
                                                         dependecyManager: dependecyManager,
                                                         movieID: movieID)
        moviePageCoordinator.start()
    }
}
