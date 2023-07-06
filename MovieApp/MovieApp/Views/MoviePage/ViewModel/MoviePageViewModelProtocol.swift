import Foundation

protocol MoviePageViewModelProtocol {
    
    var onDataLoaded: (() -> Void)? { get set }
    
    func getMovieDetails() -> MovieDetails?
    func fetchMovieDetails(by id: String)
    
    func saveCurrentMovie()
    func deleteCurrentMovie()
}
