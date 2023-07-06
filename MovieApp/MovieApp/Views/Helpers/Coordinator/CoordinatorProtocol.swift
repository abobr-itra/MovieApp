import UIKit

protocol CoordinatorProtocol {
    
    var navigationController: UINavigationController { get set }
    func start()
    func coordinate(to coordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {
    
    func coordinate(to coordinator: CoordinatorProtocol) {
        coordinator.start()
    }
}
