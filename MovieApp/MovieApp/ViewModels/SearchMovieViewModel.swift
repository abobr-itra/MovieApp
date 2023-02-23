import Foundation

protocol SearchDelegate: AnyObject {
  func reloadTableView()
}

protocol SearchMovieViewModelProtocol {
  var searchDelegate: SearchDelegate? { get set }

  func movie(at index: Int) -> Movie
  func moviesCount() -> Int

  func fetchMovies(by title: String)
}

class SearchMovieViewModel: SearchMovieViewModelProtocol {

  // MARK: Properties
  
  weak var searchDelegate: SearchDelegate?
  private let movieService: MovieServiceProtocol
  
  // TODO: Make it private(set)
  private var movies: [Movie] = []
    
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
  
  // MARK: Public

  func movie(at index: Int) -> Movie {
    return movies[index]
  }
  
  func moviesCount() -> Int {
    return movies.count
  }
  
  func fetchMovies(by title: String) {
    movieService.fetchMovies(by: title) { result in
      switch result {
      case .success(let data):
        self.movies = data.search
        self.searchDelegate?.reloadTableView()
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
}
