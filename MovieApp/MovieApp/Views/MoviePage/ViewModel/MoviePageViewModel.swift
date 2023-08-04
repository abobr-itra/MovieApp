import Combine

class MoviePageViewModel: ObservableObject, MoviePageViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    private let dataService: RealmServiceProtocol

    @Published private(set) var movieDetails: MovieDetails?
    @Published var imdbID: String = ""
    @Published private var isDataLoaded = false
    @Published private var isLoading = false

    var imdbIDPublisher: Published<String>.Publisher { $imdbID }
    var isDataLoadedPublisher: Published<Bool>.Publisher { $isDataLoaded }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }

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
        guard let movieId = movieDetails?.imdbID else { return }
        dataService.deleteObject(ofType: RealmMovie.self) { $0.imdbID == movieId }
    }
    
    // MARK: - Private
    
    private func fetchMovieDetails() {
        isLoading = true
        movieService.fetchMovieDetails(by: imdbID)
            .sink { [weak self] completion in
                self?.isLoading = false
            } receiveValue: { [weak self] movieDetails in
                self?.isLoading = false
                self?.movieDetails = movieDetails
                self?.isDataLoaded = true
            }
            .store(in: &subscriptions)
    }
}
