import Foundation

protocol MoviePageViewModelProtocol {
    
    var onDataLoaded: (() -> Void)? { get set }
    var onLoading: ((Bool) -> Void)? { get set }
    
    var movieDetails: MovieDetails? { get }
    var imdbID: String { get set }
    
    func viewDidLoad()
    func saveCurrentMovie()
    func deleteCurrentMovie()
}
