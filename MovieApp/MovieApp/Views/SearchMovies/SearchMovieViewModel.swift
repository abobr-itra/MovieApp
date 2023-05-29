import Foundation

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {

  var onDataLoaded: (() -> Void)? { get set }
  func fetchMovies(by title: String)
}

protocol MovieViewModelProtocol {

  func movie(at index: Int) -> MovieModelProtocol
  func moviesCount() -> Int
}

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {

  // MARK: - Properties
  
  var onDataLoaded: (() -> Void)?
  private let movieService: MovieServiceProtocol
  private(set) var movies: [Movie] = []
    
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
  
  // MARK: - Public

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
        self?.movies = data.search
        self?.onDataLoaded?()
      case .failure(let error):
        print("Some error occured : \(error)")
      }
    }
  }
}
