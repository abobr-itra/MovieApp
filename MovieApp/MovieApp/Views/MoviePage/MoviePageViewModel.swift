import Foundation

protocol MoviePageViewModelProtocol {

  var onDataLoaded: (() -> Void)? { get set }
  
  func getMovieDetails() -> MovieDetails?
  func fetchMovieDetails(by id: String)

  func saveCurrentMovie()
  func deleteCurrentMovie()
}

class MoviePageViewModel: MoviePageViewModelProtocol {

  // MARK: Properties
  
  var onDataLoaded: (() -> Void)?
  private var movieDetails: MovieDetails?
  private let movieService: MovieServiceProtocol
  private let dataService: RealmServiceProtocol
  
  init(movieService: MovieServiceProtocol, dataService: RealmServiceProtocol) {
    self.movieService = movieService
    self.dataService = dataService
  }
  
  // MARK: Public
  
  func getMovieDetails() -> MovieDetails? {
    movieDetails
  }
  
  func fetchMovieDetails(by id: String) {
    movieService.fetchMovieDetails(by: id) { [weak self] result in
      switch result {
      case .success(let data):
        self?.movieDetails = data
        self?.onDataLoaded?()
      case .failure(let error):
        print("Some error occured : \(error)")
      }
    }
  }
  
  func saveCurrentMovie() {
    print("Trying to save movie \(String(describing: movieDetails))")
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
