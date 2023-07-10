import Foundation

protocol WishlistViewModelProtocol: MovieViewModelProtocol {
    
    var onDataLoaded: (() -> Void)? { get set }
    var onLoading: ((Bool) -> Void)? { get set }
    
    func loadWishlist()
    func deleteMovie(by id: String)
}
