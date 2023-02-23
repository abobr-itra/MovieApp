import Foundation
import UIKit

protocol MoviePageFlow {
  
}

class MoviePageCoordinator: Coordinator, MoviePageFlow {
  
  let navigationController: UINavigationController
  let movieID: String
  
  init(navigationController: UINavigationController, movieID: String) {
    self.navigationController = navigationController
    self.movieID = movieID
  }
  
  func start() {
    let viewModelFabric = MoviePageViewModelCreator()
    let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
    
    let moviePageViewController = MoviePageViewController(viewModel: viewModel)
    moviePageViewController.movieID = movieID
    moviePageViewController.coordinator = self
    navigationController.pushViewController(moviePageViewController, animated: true)
  }
}
