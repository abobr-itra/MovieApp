import Combine

class MoviePageViewModel: ObservableObject, MoviePageViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    private let dataService: RealmServiceProtocol

    @Published private(set) var movieDetails: MovieDetails?
    @Published var imdbID: String = ""
    @Published var isDataLoaded = false
    @Published var isLoading = false

    private var subscriptions: Set<AnyCancellable> = []
    
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
        isLoading = true
        movieService.fetchMovieDetails(by: imdbID)
            .sink { [weak self] completion in
                self?.isLoading = false
                print("Recived MovieDetails Completion✅ \(completion)")
            } receiveValue: { [weak self] movieDetails in
                self?.isLoading = false
                print("MovieDetails✅: \(movieDetails)")
                self?.movieDetails = movieDetails
                self?.isDataLoaded = true
            }
            .store(in: &subscriptions)
    }
}
