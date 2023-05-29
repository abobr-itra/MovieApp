import Foundation
import UIKit

class WishlistCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModelFabric = WishlistViewModelCreator()
    let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
    
    let viewController = WishListViewController(viewModel: viewModel)
    viewController.actions = .init(openMovie: openMovie)
    
    navigationController.pushViewController(viewController, animated: false)
  }
  
  // MARK: - Private
  
  private func openMovie(_ movieID: String) {
    let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
    moviePageCoordinator.start()
  }
}
