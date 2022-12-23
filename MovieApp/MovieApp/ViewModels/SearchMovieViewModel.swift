import Foundation

protocol SearchDelegate: AnyObject {
  func reloadTableView()
}

protocol DetailsDelegate: AnyObject {
  func updateView(with data: MovieDetails)
}

protocol SearchMovieViewModelProtocol {
  var searchDelegate: SearchDelegate? { get set }
  var detailsDelegate: DetailsDelegate? { get set }
  
  var movieDetails: MovieDetails? { get set }
  
  func movie(at index: Int) -> Movie
  func moviesCount() -> Int

  func fetchMovies(by title: String)
  func fetchMovieDetails(by id: String)
}

class SearchMovieViewModel: SearchMovieViewModelProtocol {

  // MARK: Properties
  
  weak var searchDelegate: SearchDelegate?
  weak var detailsDelegate: DetailsDelegate?
  private let movieService: MovieServiceProtocol
  
  // TODO: Make it private(set)
  var movies: [Movie] = []
  var movieDetails: MovieDetails?
    
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
  
  func fetchMovieDetails(by id: String) {
    movieService.fetchMovieDetails(by: id) { result in
      switch result {
      case .success(let data):
        self.movieDetails = data
        self.detailsDelegate?.updateView(with: data)
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
  
  // MARK: Private
}
