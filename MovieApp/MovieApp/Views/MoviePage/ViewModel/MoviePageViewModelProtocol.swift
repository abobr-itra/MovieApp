import Foundation

protocol MoviePageViewModelProtocol {

    var movieDetails: MovieDetails? { get }
    var imdbID: String { get set }
    var imdbIDPublisher: Published<String>.Publisher { get }
    var isDataLoadedPublisher: Published<Bool>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    func viewDidLoad()
    func saveCurrentMovie()
    func deleteCurrentMovie()
}
