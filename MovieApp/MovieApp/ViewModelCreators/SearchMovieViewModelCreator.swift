import Foundation
import Swinject

class SearchMovieViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SearchMovieViewModel
    
    private unowned let coordinator: SearchMovieCoordinatorProtocol
    private var dependencyManager: DependencyManager
    
    init(coordinator: SearchMovieCoordinatorProtocol, dependencyManager: DependencyManager) {
        self.coordinator = coordinator
        self.dependencyManager = dependencyManager
    }
    
    func factoryMethod() -> SearchMovieViewModel {
        let movieService = dependencyManager.resolver.resolve(MovieServiceProtocol.self)!
        return SearchMovieViewModel(movieService: movieService, coordinator: coordinator)
    }
}
