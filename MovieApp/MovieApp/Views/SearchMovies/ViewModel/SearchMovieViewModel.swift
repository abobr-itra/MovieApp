import Foundation

class SearchMovieViewModel: MovieViewModelProtocol, SearchMovieViewModelProtocol {
    
    // MARK: - Properties
    
    private let movieService: MovieServiceProtocol
    
    var onDataLoaded: (() -> Void)?
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
    
    func fetchMovies(by title: String) {
        movieService.fetchMovies(by: title) { [weak self] result in
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
