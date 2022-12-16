import Foundation

protocol MovieServiceProtocol {
  func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void)
  func fetchMovieDetails(by title: String, completion: @escaping (Result<MovieDetails, RequestError>) -> Void)
}

class MovieService: MovieServiceProtocol {
  // MARK: Properties
  
  private let networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
  
  // MARK: Public
  
  func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void) {
    let url = OMDBEndpoint.bySearch(title).url
    networkService.getData(from: url, resultHandler: completion)
  }
  
  func fetchMovieDetails(by title: String, completion: @escaping (Result<MovieDetails, RequestError>) -> Void) {
    let url = OMDBEndpoint.byTitle(title).url
    networkService.getData(from: url, resultHandler: completion)
  }
  
  // MARK: Private
}
