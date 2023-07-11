import Foundation

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {

    var onDataLoaded: (() -> Void)? { get set }
    var onLoading: ((Bool) -> Void)? { get set }
    var movieTitle: String { get set }
    var movies: [Movie] { get }
    
    func searchMovies(by title: String)
    func viewDidLoad()
}
