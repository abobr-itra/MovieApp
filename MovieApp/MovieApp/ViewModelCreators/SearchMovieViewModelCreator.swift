import Foundation

class SearchMovieViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SearchMovieViewModel
    
    private let coordinator: SearchMovieCoordinatorProtocol
    
    init(coordinator: SearchMovieCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod(parser: NetworkPaserProtocol) -> SearchMovieViewModel {
        let networkService = NetworkService(parser: parser)
        let movieService = MovieService(networkService: networkService)
        return SearchMovieViewModel(movieService: movieService, coordinator: coordinator)
    }
}
