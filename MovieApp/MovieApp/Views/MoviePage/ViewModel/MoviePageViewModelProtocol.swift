import Foundation

protocol MoviePageViewModelProtocol {
    
    var onDataLoaded: (() -> Void)? { get set }
    
    var movieDetails: MovieDetails? { get }
    func fetchMovieDetails(by id: String)
    
    func saveCurrentMovie()
    func deleteCurrentMovie()
}
