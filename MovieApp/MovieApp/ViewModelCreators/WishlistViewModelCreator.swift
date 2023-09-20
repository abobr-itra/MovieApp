import Foundation
import RealmSwift
import Swinject

class WishlistViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = WishlistViewModel
    
    private unowned let coordinator: WishlistCoordinatorProtocol
    
    init(coordinator: WishlistCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func factoryMethod() -> WishlistViewModel {
        let dataService = Container.shared.resolve(RealmServiceProtocol.self)!
        return WishlistViewModel(dataService: dataService, coordinator: coordinator)
    }
}
