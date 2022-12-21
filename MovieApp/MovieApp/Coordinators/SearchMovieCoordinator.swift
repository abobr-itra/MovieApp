import Foundation
import UIKit

protocol SearchMovieFlow {
  func coordinateToMoviePage(by movieID: String)
}

class SearchMovieCoordinator: Coordinator, SearchMovieFlow {

  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let searchMovieViewController = SearchMovieViewController()
    searchMovieViewController.coordinator = self
    navigationController.pushViewController(searchMovieViewController, animated: true)
  }
  
  func coordinateToMoviePage(by movieID: String) {
    // Get MoviePageCoordinator and coordinate to it
    let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
    coordinate(to: moviePageCoordinator)
  }
}
