import UIKit

class WishListViewController: UIViewController, RefreshableViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var tableView: UITableView!
  private var viewModel: WishlistViewModelProtocol?
  var spinner: SpinnerViewController = SpinnerViewController()
  private var tableViewController: MovieTableViewController?
  
  struct Actions {
    var openMovie: (_ movieID: String) -> Void
  }
  
  var actions: Actions?
  
  convenience init(viewModel: WishlistViewModelProtocol) {
    self.init(nibName: nil, bundle: nil)
    print("♦️WishlistViewModelProtocol init viewModel:", viewModel)
    self.viewModel = viewModel
    
    tableViewController = MovieTableViewController(viewModel: viewModel, tableView: tableView)
    if let openMovie = actions?.openMovie {
      tableViewController?.actions = .init(openMovie: openMovie)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tabBarController?.delegate = self
    loadWishlist()
  }
  
  // MARK: - Private

  private func loadWishlist() {
    showSpinner()
    viewModel?.onDataLoaded = { [weak self] in
      DispatchQueue.main.async {
        self?.tableViewController?.tableView.reloadData()
        self?.hideSpinner()
      }
    }
    viewModel?.loadWishlist()
  }
}

extension WishListViewController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    DispatchQueue.main.async {
      self.loadWishlist()
    }
  }
}
