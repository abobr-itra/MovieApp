import Foundation
import Combine

class MoviePageViewModel: ObservableObject, MoviePageViewModelProtocol {
    
    // MARK: - Properties
    
    var onDataLoaded: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    private let movieService: MovieServiceProtocol
    private let dataService: RealmServiceProtocol

    @Published private(set) var movieDetails: MovieDetails?
    @Published var imdbID: String = ""

    private var subscriptions = Set<AnyCancellable>()
    
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
        guard let movieDetails else { return }
        let movieId = movieDetails.imdbID
        dataService.deleteMovie(by: movieId)
    }
    
    // MARK: - Private
    
    private func fetchMovieDetails() {
        onLoading?(true)
        movieService.fetchMovieDetails(by: imdbID)
            .sink { _ in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                print("Recived MovieDetails Completion✅")
            } receiveValue: { movieDetails in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                print("MovieDetails✅: \(movieDetails)")
                self.movieDetails = movieDetails
                self.onDataLoaded?()
            }
            .store(in: &subscriptions)
    }
}
