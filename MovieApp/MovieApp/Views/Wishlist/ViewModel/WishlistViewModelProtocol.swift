import Foundation

protocol WishlistViewModelProtocol: MovieViewModelProtocol {

    var isDataLoadedPublisher: Published<Bool>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    func loadWishlist()
    func deleteMovie(by id: String)
}
