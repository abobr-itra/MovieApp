import Foundation
import UIKit
import Combine

class SearchMovieViewModel: ObservableObject, MovieViewModelProtocol, SearchMovieViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private(set) var movies: [Movie] = []
    @Published var movieTitle = ""
    @Published var isDataLoaded = false
    @Published var isLoading = false
    
    var moviesCount: Int {
        movies.count
    }
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        observeSearch()
    }
    
    // MARK: - Public
    
    func movie(at index: Int) -> MovieModelProtocol {
        movies[index]
    }

    // MARK: - Private

    private func observeSearch() {
        $movieTitle
            .removeDuplicates()
            .dropFirst()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .flatMap { (movieTitle: String) -> AnyPublisher<MovieSearch, Never> in
                self.movies = []
                self.isDataLoaded = true
                self.isLoading = true
                
                return self.movieService.fetchMovies(by: movieTitle)
                    .replaceError(with: Constants.MockData.movieSearchMock)
                    .eraseToAnyPublisher()
            }
            .map(\.search)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("SearhMovieVM: Recived error completion: \(error)")
                case .finished:
                    print("SearhMovieVM: Recived fineshed completion")
                }
            } receiveValue: { movies in
                self.isLoading = false
                self.movies = movies
                self.isDataLoaded = true
            }
            .store(in: &subscriptions)
    }
}
