import Foundation

protocol MovieViewModelProtocol {
    
    func movie(at index: Int) -> MovieModelProtocol
    var moviesCount: Int { get }
    func remove(at index: Int)
    
    func openMovie(_ movieID: String)
}
