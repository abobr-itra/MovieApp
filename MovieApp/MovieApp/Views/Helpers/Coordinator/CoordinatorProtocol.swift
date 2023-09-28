import UIKit

protocol CoordinatorProtocol: AnyObject {

    var navigationController: UINavigationController { get set }
    var dependecyManager: DependencyManager { get }

    func start()
    func coordinate(to coordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {

    func coordinate(to coordinator: CoordinatorProtocol) {
        coordinator.start()
    }
}
