import Foundation
import RealmSwift

class WishlistViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = WishlistViewModel
    
    private let coordinator: WishlistCoordinatorProtocol
    
    init(coordinator: WishlistCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod(parser: NetworkPaserProtocol) -> WishlistViewModel {
        let realm = try? Realm()
        let dataService = RealmService(realm: realm)
        return WishlistViewModel(dataService: dataService, coordinator: coordinator)
    }
}
