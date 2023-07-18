import Foundation
import RealmSwift

class WishlistViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = WishlistViewModel
    
    func factoryMethod(parser: NetworkPaserProtocol) -> WishlistViewModel {
        let realm = try? Realm()
        let dataService = RealmService(realm: realm)
        return WishlistViewModel(dataService: dataService)
    }
}
