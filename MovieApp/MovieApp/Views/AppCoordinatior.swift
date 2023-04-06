import UIKit

protocol Coordinator {
  func start()
  func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
  func coordinate(to coordinator: Coordinator) {
    coordinator.start()
  }
}

class AppCoordinatior: Coordinator {

  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let navigationController = UINavigationController()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    let searchMovieCoordinator = SearchMovieCoordinator(navigationController: navigationController)
    let wishlistCoordinator = WishlistCoordinator(navigationController: navigationController)
    coordinate(to: wishlistCoordinator)
  }
}
