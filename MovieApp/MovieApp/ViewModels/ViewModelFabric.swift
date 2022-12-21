import Foundation

protocol ViewModelCreator {
  associatedtype ViewModel
  func factoryMethod(parser: NetworkPaserProtocol) -> ViewModel
}

class SearchMovieViewModelCreator: ViewModelCreator {
  typealias ViewModel = SearchMovieViewModel
  func factoryMethod(parser: NetworkPaserProtocol) -> SearchMovieViewModel {
    let networkService = NetworkService(parser: parser)
    let movieService = MovieService(networkService: networkService)
    return SearchMovieViewModel(movieService: movieService)
  }
}
