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

class MoviePageViewModelCreator: ViewModelCreator {
  typealias ViewModel = MoviePageViewModel
  func factoryMethod(parser: NetworkPaserProtocol) -> MoviePageViewModel {
    let networkService = NetworkService(parser: parser)
    let dataService = RealmService()
    let movieService = MovieService(networkService: networkService)
    return MoviePageViewModel(movieService: movieService, dataService: dataService)
  }
}

class WishlistViewModelCreator: ViewModelCreator {
  typealias ViewModel = WishlistViewModel
  func factoryMethod(parser: NetworkPaserProtocol) -> WishlistViewModel {
    let networkService = NetworkService(parser: parser)
    let dataService = RealmService()
    return WishlistViewModel(dataService: dataService)
  }
}
