import Foundation

protocol ViewDelegate: AnyObject {
  func reloadTableView(with movies: [Movie])
}

protocol MovieViewModelProtocol {
  var delegate: ViewDelegate? { get set }
  func fetchMovies(by title: String)
}

class MovieViewModel: MovieViewModelProtocol {
  // MARK: Properties
  
  weak var delegate: ViewDelegate?
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
        self.delegate?.reloadTableView(with: movies)
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
  
  func fetchMovieDetails(by title: String) {
    movieService.fetchMovieDetails(by: title) { result in
      switch result {
      case .success(let data):
        print(data)
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
  
  // MARK: Private
}
