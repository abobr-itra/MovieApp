import Foundation

class MoviePageViewModel: MoviePageViewModelProtocol {
    
    // MARK: - Properties
    
    var onDataLoaded: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    private(set) var movieDetails: MovieDetails?
    private let movieService: MovieServiceProtocol
    private let dataService: RealmServiceProtocol
    var imdbID: String = ""
    
    init(movieService: MovieServiceProtocol, dataService: RealmServiceProtocol) {
        self.movieService = movieService
        self.dataService = dataService
    }
    
    // MARK: - Public
    
    func viewDidLoad() {
        fetchMovieDetails()
    }

    func saveCurrentMovie() {
        print("Trying to save movie \(String(describing: movieDetails))")
        guard let movieDetails else { return }
        let realmMovie = RealmMovie(from: movieDetails)
        dataService.saveObject(realmMovie)
    }
    
    func deleteCurrentMovie() {
        guard let movieId = movieDetails?.imdbID else { return }
        dataService.deleteObject(ofType: RealmMovie.self) { $0.imdbID == movieId }
    }
    
    // MARK: - Private
    
    private func fetchMovieDetails() {
        onLoading?(true)
        movieService.fetchMovieDetails(by: imdbID) { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoading?(false)
            }
            switch result {
            case .success(let data):
                self?.movieDetails = data
                self?.onDataLoaded?()
            case .failure(let error):
                print("Some error occured : \(error)")
            }
        }
    }
}
