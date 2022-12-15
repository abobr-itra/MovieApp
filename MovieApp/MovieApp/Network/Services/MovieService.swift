import Foundation

protocol MovieServiceProtocol {
  func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void)
}

class MovieService: MovieServiceProtocol {
  // MARK: Properties
  
  private let networkService: NetworkServiceProtocol
  
  init(networkService: NetworkServiceProtocol) {
    self.networkService = networkService
  }
  
  // MARK: Public
  
  func fetchMovies(by title: String, completion: @escaping (Result<MovieSearch, RequestError>) -> Void) {
    let url = OMDBEndpoint.byTitle(title).url
    networkService.getData(from: url, resultHandler: completion)
  }
  
  // MARK: Private
}
