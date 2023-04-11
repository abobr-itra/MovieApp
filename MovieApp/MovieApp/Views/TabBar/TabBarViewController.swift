import UIKit

class TabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UITabBar.appearance().barTintColor = .systemBackground
    tabBar.tintColor = .label
    setupVCs()
  }
  
  fileprivate func createNavController(for rootViewController: UIViewController,
                                       title: String,
                                       image: UIImage) -> UIViewController {
    let navController = UINavigationController(rootViewController: rootViewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = image
    navController.navigationBar.prefersLargeTitles = true
    rootViewController.navigationItem.title = title
    return navController
  }
  
  func setupVCs() {
    viewControllers = [
      createNavController(for: SearchMovieCoordinator(navigationController: UINavigationController()).navigationController, title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
      createNavController(for: WishlistCoordinator(navigationController: UINavigationController()).navigationController
,
                          title: NSLocalizedString("Home", comment: ""),
                          image: UIImage(systemName: "house")!),
    ]
  }
  
}
