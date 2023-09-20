import Foundation
import Swinject

class SearchMovieViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SearchMovieViewModel
    
    private unowned let coordinator: SearchMovieCoordinatorProtocol
    
    init(coordinator: SearchMovieCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod() -> SearchMovieViewModel {
        let movieService = Container.shared.resolve(MovieServiceProtocol.self)!
        return SearchMovieViewModel(movieService: movieService, coordinator: coordinator)
    }
}
