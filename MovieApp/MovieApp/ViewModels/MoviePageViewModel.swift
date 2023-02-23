import Foundation

protocol DetailsDelegate: AnyObject {
  func updateView()
}

protocol MoviePageViewModelProtocol {
  var detailsDelegate: DetailsDelegate? { get set }
  
  func getMovieDetails() -> MovieDetails?
  func fetchMovieDetails(by id: String)
}

class MoviePageViewModel: MoviePageViewModelProtocol {
  // MARK: Properties
  
  weak var detailsDelegate: DetailsDelegate?
  private var movieDetails: MovieDetails?
  private let movieService: MovieServiceProtocol
  
  init(movieService: MovieServiceProtocol) {
    self.movieService = movieService
  }
  
  // MARK: Public
  
  func getMovieDetails() -> MovieDetails? {
    return movieDetails
  }

  func fetchMovieDetails(by id: String) {
    movieService.fetchMovieDetails(by: id) { result in
      switch result {
      case .success(let data):
        self.movieDetails = data
        self.detailsDelegate?.updateView()
      case .failure(let error):
        print("Some error occured :", error)
      }
    }
  }
}
