import Foundation

protocol ViewDelegate {
  func reloadTableView(with movies: [Movie])
}

protocol MovieViewModelProtocol {
  var delegate: ViewDelegate? { get set }
  func fetchMovies(by title: String)
}

class MovieViewModel: MovieViewModelProtocol {
  // MARK: Properties
  
  var delegate: ViewDelegate?
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
  
  // MARK: Private
}
