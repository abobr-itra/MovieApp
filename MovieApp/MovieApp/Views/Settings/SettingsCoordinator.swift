import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
  
  // MARK: - Properties
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Public
  
  func start() {
    let viewModelCreator = SettingsViewModelCreator()
    let viewModel = viewModelCreator.factoryMethod(parser: NetworkParser())
    
    let viewController = SettingsViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: false)
  }
}
