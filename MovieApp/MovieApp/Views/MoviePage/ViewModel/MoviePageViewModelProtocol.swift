import Foundation

protocol MoviePageViewModelProtocol {

    var movieDetails: MovieDetails? { get }
    var imdbID: String { get set }
    var isDataLoaded: Bool { get set }
    var isLoading: Bool { get set }

    func viewDidLoad()
    func saveCurrentMovie()
    func deleteCurrentMovie()
}
