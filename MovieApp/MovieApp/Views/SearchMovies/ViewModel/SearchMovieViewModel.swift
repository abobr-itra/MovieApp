import Foundation
import UIKit
import Combine

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private(set) var movies: [Movie] = []
    @Published var movieTitle = ""
    @Published var isDataLoaded = false
    @Published var isLoading = false
    
    var moviesCount: Int {
        return movies.count
    }
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        observeSearch()
    }
    
    // MARK: - Public
    
    func bindMovieTitle(publisher: NotificationCenter.Publisher) {
        publisher
            .compactMap { ($0.object as? UISearchTextField)?.text }
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .assign(to: \.movieTitle, on: self)
            .store(in: &subscriptions)
    }
    
    func viewDidAppear() {
        observeSearch()
    }
    
    func movie(at index: Int) -> MovieModelProtocol {
        movies[index]
    }
    
    func searchMovies(by title: String) {
        movies = []
        isDataLoaded = true
        isLoading = true
        movieService.fetchMovies(by: title)
            .sink { completion in
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    print("Recived SearchMovies Completion Error❌: \(error)")
                    self.movies = []
                    self.isDataLoaded = true
                case .finished:
                    print("Recived SearchMovies Completion Finished✅")
                }
            } receiveValue: { searchData in
                self.isLoading = false
                print("Movies✅: \(searchData)")
                self.movies = searchData.search
                self.isDataLoaded = true
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Private
    
    private func observeSearch() {
        $movieTitle
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .flatMap { (movieTitle: String) -> AnyPublisher<MovieSearch, RequestError> in
                print("ViewModel movieTitle ✅: \(movieTitle)")
                self.isLoading = true
                return self.movieService.fetchMovies(by: movieTitle)
            }
            .map(\.search)
            .sink { completion in
                self.isLoading = false
                print("Recived SearchMovies Completion✅🤡: \(completion)")
            } receiveValue: { movies in
                self.isLoading = false
                print("Movies✅: \(movies)🤡")
                self.movies = movies
                self.isDataLoaded = true
            }
            .store(in: &subscriptions)
    }
}
