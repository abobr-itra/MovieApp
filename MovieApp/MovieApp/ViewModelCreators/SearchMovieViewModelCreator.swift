import Foundation

class SearchMovieViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = SearchMovieViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> SearchMovieViewModel {
        let networkService = NetworkService(parser: parser)
        let movieService = MovieService(networkService: networkService)
        return SearchMovieViewModel(movieService: movieService)
    }
}
