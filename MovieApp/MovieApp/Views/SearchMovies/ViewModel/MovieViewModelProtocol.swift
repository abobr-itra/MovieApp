import Foundation

protocol MovieViewModelProtocol {
    
    func movie(at index: Int) -> MovieModelProtocol
    func moviesCount() -> Int
}
