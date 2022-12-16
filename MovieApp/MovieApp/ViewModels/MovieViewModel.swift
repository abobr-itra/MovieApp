import Foundation

protocol SearchDelegate: AnyObject { // 'weak' must not be applied to non-class-bound 'any SearchDelegate'; consider adding a protocol conformance that has a class bound
  func reloadTableView(with movies: [Movie])
}

protocol DetailsDelegate: AnyObject {
  func updateView(with data: MovieDetails)
}

protocol MovieViewModelProtocol {
  var searchDelegate: SearchDelegate? { get set }
  var detailsDelegate: DetailsDelegate? { get set }
  func fetchMovies(by title: String)
  func fetchMovieDetails(by id: String)
}

class MovieViewModel: MovieViewModelProtocol {
  // MARK: Properties
  
  weak var searchDelegate: SearchDelegate?
  weak var detailsDelegate: DetailsDelegate?
  private let movieService: MovieServiceProtocol
  
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
  
  // MARK: Public
  
  func fetchMovies(by title: String) {
    movieService.fetchMovies(by: title) { result in
      switch result {
      case .success(let data):
        let movies = data.search
        self.searchDelegate?.reloadTableView(with: movies)
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
  
  func fetchMovieDetails(by id: String) {
    movieService.fetchMovieDetails(by: id) { result in
      switch result {
      case .success(let data):
        print(data)
        self.detailsDelegate?.updateView(with: data)
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
  
  // MARK: Private
}
