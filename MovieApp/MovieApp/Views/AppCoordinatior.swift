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
    tabBarController.tabBar.tintColor = .tabBarTintColor
    
    window.rootViewController = tabBarController
    window.makeKeyAndVisible()
    
    // TODO: Remove navigation controllers for this coordinators
    
    let searchMovieCoordinator = SearchMovieCoordinator(navigationController: UINavigationController())
    let wishlistCoordinator = WishlistCoordinator(navigationController: UINavigationController())
    let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())

    let searchVC = setupViewController(coordinator: searchMovieCoordinator,
                                       title: "Search",
                                       image: Constants.TabBar.searchImage)
    let wishlistVC = setupViewController(coordinator: wishlistCoordinator,
                                         title: "Wishlist",
                                         image: Constants.TabBar.wishlistImage)
    let settingsVC = setupViewController(coordinator: settingsCoordinator,
                                         title: "Settings",
                                         image: Constants.TabBar.settingsImage)
    
    
    let viewControllers = [searchVC, wishlistVC, settingsVC]
    tabBarController.viewControllers = viewControllers
    
    coordinate(to: searchMovieCoordinator)
    coordinate(to: wishlistCoordinator)
    coordinate(to: settingsCoordinator)
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
