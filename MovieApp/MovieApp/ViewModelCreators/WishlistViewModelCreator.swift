import Foundation
import RealmSwift
import Swinject

class WishlistViewModelCreator: ViewModelCreatorProtocol {
    
    typealias ViewModel = WishlistViewModel
    
    private unowned let coordinator: WishlistCoordinatorProtocol
    private var dependencyManager: DependencyManager

    init(coordinator: WishlistCoordinatorProtocol, dependencyManager: DependencyManager) {
        self.coordinator = coordinator
        self.dependencyManager = dependencyManager
    }

    func factoryMethod() -> WishlistViewModel {
        let dataService = dependencyManager.resolver.resolve(RealmServiceProtocol.self)!
        return WishlistViewModel(dataService: dataService, coordinator: coordinator)
    }
}
