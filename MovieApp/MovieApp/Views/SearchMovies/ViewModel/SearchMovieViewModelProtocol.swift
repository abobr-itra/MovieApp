import Foundation

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {

    var onDataLoaded: (() -> Void)? { get set }
    func fetchMovies(by title: String)
}
