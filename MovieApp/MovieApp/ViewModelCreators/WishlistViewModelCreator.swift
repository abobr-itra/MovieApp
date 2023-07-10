import Foundation

class WishlistViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = WishlistViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> WishlistViewModel {
        let dataService = RealmService()
        return WishlistViewModel(dataService: dataService)
    }
}
