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
    let tabBarController = UITabBarController()
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    
    let searchMovieCoordinator = SearchMovieCoordinator(navigationController: UINavigationController())
    let wishlistCoordinator = WishlistCoordinator(navigationController: UINavigationController())
    
    let searchVC = searchMovieCoordinator.navigationController
    let wishlistVC = wishlistCoordinator.navigationController
    let searchItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
    let wishlistItem = UITabBarItem(title: "Wishlist", image: UIImage(systemName: "star"), tag: 1)
    searchVC.tabBarItem = searchItem
    wishlistVC.tabBarItem = wishlistItem
    
    let viewControllers = [searchVC, wishlistVC]
    
    tabBarController.viewControllers = viewControllers
    
    coordinate(to: searchMovieCoordinator)
  }
}
