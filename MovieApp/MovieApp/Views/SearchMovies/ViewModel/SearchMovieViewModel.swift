import Foundation

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    
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
        movieService.fetchMovies(by: title) { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoading?(false)
            }
            switch result {
            case .success(let data):
                self?.movies = data.search
                self?.onDataLoaded?()
            case .failure(let error):
                print("Some error occured : \(error)")
            }
        }
    }
}
