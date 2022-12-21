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
    let moviePageViewController = MoviePageViewController()
    moviePageViewController.movieID = movieID
    moviePageViewController.coordinator = self
    navigationController.pushViewController(moviePageViewController, animated: true)
  }
}
