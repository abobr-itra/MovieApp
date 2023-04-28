import Foundation

protocol SearchDelegate: AnyObject {

  func reloadTableView()
}

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {

  var searchDelegate: SearchDelegate? { get set }
  func fetchMovies(by title: String)
}

protocol MovieViewModelProtocol {
  func movie(at index: Int) -> MovieModelProtocol
  func moviesCount() -> Int
}

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {

  // MARK: Properties
  
  weak var searchDelegate: SearchDelegate?
  private let movieService: MovieServiceProtocol
  
  // TODO: Make it private(set)
  private(set) var movies: [Movie] = []
    
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
  
  // MARK: Public

  func movie(at index: Int) -> MovieModelProtocol {
    movies[index]
  }
  
  func moviesCount() -> Int {
    movies.count
  }
  
  func fetchMovies(by title: String) {
    movieService.fetchMovies(by: title) { [weak self] result in
      switch result {
      case .success(let data):
        print(data)
        self?.movies = data.search
        self?.searchDelegate?.reloadTableView()
      case .failure(let error):
        print("Some error occured : \(error)")
      }
    }
  }
}
