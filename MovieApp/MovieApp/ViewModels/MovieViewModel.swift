import Foundation

protocol ViewDelegate {
  func reloadTableView(with movies: [Movie])
}

protocol MovieViewModelProtocol {
  func fetchMovies(by title: String)
}

class MovieViewModel: MovieViewModelProtocol {
  // MARK: Properties
  
  private var delegate: ViewDelegate?
  private let movieService: MovieServiceProtocol
  private var movies: [Movie] = []
  
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
  
  // MARK: Public
  
  func fetchMovies(by title: String) {
    print("Start fetching")
    movieService.fetchMovies(by: title) { result in
      switch result {
      case .success(let data):
        self.movies = data.search
        print("Fetched movies :", self.movies)
        self.delegate?.reloadTableView(with: self.movies)
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
  
  // MARK: Private
}
