import Foundation
import Combine

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    var onDataLoaded: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    @Published private(set) var movies: [Movie] = []
    @Published var movieTitle = ""
    
    var moviesCount: Int {
        return movies.count
    }
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    // MARK: - Public
    
    func viewDidLoad() {
        observeSearch()
    }
    
    func movie(at index: Int) -> MovieModelProtocol {
        movies[index]
    }
    
    func searchMovies(by title: String) {
        guard !title.isEmpty else {
            movies = []
            self.onDataLoaded?()
            return
        }
        onLoading?(true)
        movieService.fetchMovies(by: title)
            .sink { completion in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                switch completion {
                case .failure(let error):
                    print("Recived SearchMovies Completion Error❌: \(error)")
                    self.movies = []
                    self.onDataLoaded?()
                case .finished:
                    print("Recived SearchMovies Completion Finished✅")
                }
            } receiveValue: { searchData in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                print("Movies✅: \(searchData)")
                self.movies = searchData.search
                self.onDataLoaded?()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Private
    
    private func observeSearch() {
        $movieTitle
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .flatMap { (movieTitle: String) -> AnyPublisher<MovieSearch, RequestError> in
                print("ViewModel movieTitle ✅: \(movieTitle)")
                DispatchQueue.main.async {
                    self.onLoading?(true)
                }
                return self.movieService.fetchMovies(by: movieTitle)
            }
            .map(\.search)
            .sink { _ in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                print("Recived SearchMovies Completion✅")
            } receiveValue: { movies in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                print("Movies✅: \(movies)")
                self.movies = movies
                self.onDataLoaded?()
            }
            .store(in: &subscriptions)
    }
}
