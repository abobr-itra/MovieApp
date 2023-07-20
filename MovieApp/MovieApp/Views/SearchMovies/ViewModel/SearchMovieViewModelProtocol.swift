import Foundation

protocol SearchMovieViewModelProtocol: MovieViewModelProtocol {
    
    var movieTitle: String { get set }
    
    var moviesPublisher: Published<[Movie]>.Publisher { get }
    var movieTitlePublisher: Published<String>.Publisher { get }
    var isDataLoadedPublisher: Published<Bool>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
}
