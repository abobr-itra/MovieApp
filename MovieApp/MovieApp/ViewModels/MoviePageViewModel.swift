import Foundation

protocol DetailsDelegate: AnyObject {
  func updateView()
}

protocol MoviePageViewModelProtocol {
  var detailsDelegate: DetailsDelegate? { get set }
  
  func getMovieDetails() -> MovieDetails?
  func fetchMovieDetails(by id: String)

  func saveCurrentMovie()
  func deleteCurrentMovie()
}

class MoviePageViewModel: MoviePageViewModelProtocol {
  // MARK: Properties
  
  weak var detailsDelegate: DetailsDelegate?
  private var movieDetails: MovieDetails?
  private let movieService: MovieServiceProtocol
  private let dataService: RealmServiceProtocol
  
  init(movieService: MovieServiceProtocol, dataService: RealmServiceProtocol) {
    self.movieService = movieService
    self.dataService = dataService
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
  
  func saveCurrentMovie() {
    guard let movieDetails else { return }
    let realmMovie = RealmMovie(from: movieDetails)
    dataService.saveObject(realmMovie)
  }
  
  func deleteCurrentMovie() {
    guard let movieDetails else { return }
    let movieId = movieDetails.imdbID
    dataService.deleteMovie(by: movieId)
  }
}
