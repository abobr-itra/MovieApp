import Foundation
import Combine

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    var onDataLoaded: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    private(set) var movies: [Movie] = []
    var moviesCount: Int {
        return movies.count
    }
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    // MARK: - Public
    
    func movie(at index: Int) -> MovieModelProtocol {
        movies[index]
    }
    
    func searchMovies(by title: String) {
        onLoading?(true)
        movieService.fetchMovies(by: title)
            .sink { _ in
                DispatchQueue.main.async {
                    self.onLoading?(false)
                }
                print("Recived Completion✅")
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
}
