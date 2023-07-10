import Foundation

protocol MovieViewModelProtocol {
    
    func movie(at index: Int) -> MovieModelProtocol
    var moviesCount: Int { get }
}
