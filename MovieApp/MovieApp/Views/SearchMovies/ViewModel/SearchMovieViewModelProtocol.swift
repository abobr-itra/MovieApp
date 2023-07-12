import Foundation

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {
    
    var movieTitle: String { get set }
    var movies: [Movie] { get }
    var isDataLoaded: Bool { get set }
    var isLoading: Bool { get set }
}
