import UIKit

class SearchMovieCoordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    
    func start() {
        let viewModelFabric = SearchMovieViewModelCreator()
        let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
        
        let viewController = SearchMoviesViewController(viewModel: viewModel)
        viewController.actions = .init(openMovie: openMovie)
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // MARK: - Private
    
    private func openMovie(_ movieID: String) {
        let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
        moviePageCoordinator.start()
    }
}
