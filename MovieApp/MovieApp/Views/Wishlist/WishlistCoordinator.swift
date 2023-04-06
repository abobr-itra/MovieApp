import Foundation
import UIKit

class WishlistCoordinator: Coordinator {
  
  // MARK: Properties
  
  private var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModelFabric = WishlistViewModelCreator()
    let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
    print("♦️WishlistViewModel start() viewModel:", viewModel)
    
    let viewController = WishListViewController(viewModel: viewModel)
//    viewController.data = .init()
//    viewController.actions = .init(openMovie: openMovie)
    
    navigationController.pushViewController(viewController, animated: false)
  }
}
