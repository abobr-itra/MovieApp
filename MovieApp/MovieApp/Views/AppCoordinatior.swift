import UIKit

protocol Coordinator {
  var navigationController: UINavigationController { get set }
  func start()
  func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
  func coordinate(to coordinator: Coordinator) {
    coordinator.start()
  }
}

class AppCoordinatior: Coordinator {
  
  // MARK: - Private Propertis
  
  private let window: UIWindow
  private var tag = 0
  
  // MARK: - Public Properties
  
  var navigationController: UINavigationController = UINavigationController()
  
  init(window: UIWindow) {
    self.window = window
  }
  
  // MARK: - Public
  
  func start() {
    let tabBarController = UITabBarController()
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    
    let searchMovieCoordinator = SearchMovieCoordinator(navigationController: UINavigationController())
    let wishlistCoordinator = WishlistCoordinator(navigationController: UINavigationController())

    let searchVC = setupViewController(coordinator: searchMovieCoordinator,
                                       title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"))
    let wishlistVC = setupViewController(coordinator: wishlistCoordinator,
                                         title: "Wishlist",
                                         image: UIImage(systemName: "star"))
    
    let viewControllers = [searchVC, wishlistVC]
    tabBarController.viewControllers = viewControllers
    
    coordinate(to: searchMovieCoordinator)
    coordinate(to: wishlistCoordinator)
  }
  
  // MARK: - Private
  
  private func generateTag() -> Int {
    tag += 1
    return tag
  }
  
  private func setupViewController(coordinator: Coordinator, title: String, image: UIImage?) -> UIViewController {
    let viewController = coordinator.navigationController
    let tabBarItem = UITabBarItem(title: title, image: image, tag: generateTag())
    viewController.tabBarItem = tabBarItem
    return viewController
  }
}
