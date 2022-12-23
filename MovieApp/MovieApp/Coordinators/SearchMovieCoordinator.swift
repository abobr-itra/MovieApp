import Foundation
import UIKit

protocol SearchMovieFlow {
  func coordinateToMoviePage(by movieID: String)
}

class SearchMovieCoordinator: Coordinator, SearchMovieFlow {

  // MARK: Properties
  
  private var navigationController: UINavigationController
  private var viewModel: SearchMovieViewModelProtocol?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: Public

  func start() {
    
    let viewModelFabric = SearchMovieViewModelCreator()
    let viewModel = viewModelFabric.factoryMethod(parser: NetworkParser())
    
    let searchMovieViewController = SearchMovieViewController(viewModel: viewModel)

    searchMovieViewController.coordinator = self
    navigationController.pushViewController(searchMovieViewController, animated: false)
  }
  
  func coordinateToMoviePage(by movieID: String) {
    // Get MoviePageCoordinator and coordinate to it
    let moviePageCoordinator = MoviePageCoordinator(navigationController: navigationController, movieID: movieID)
    coordinate(to: moviePageCoordinator)
  }
}
