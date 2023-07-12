import Foundation

protocol WishlistViewModelProtocol: MovieViewModelProtocol {
    
    var isDataLoaded: Bool { get set }
    var isLoading: Bool { get set }
    
    func loadWishlist()
    func deleteMovie(by id: String)
}
