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

class MainCoordinatior: Coordinator {

  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let navigationController = UINavigationController()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    // Navigate to first coordiantor
    let searchMovieCoordinator = SearchMovieCoordinator(navigationController: navigationController)
    coordinate(to: searchMovieCoordinator)
  }
}
