import UIKit

class WishListViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MoiveListDataSource?
    private var delegate: MovieListDelegate?
    
    private var viewModel: WishlistViewModelProtocol?
    var spinner: SpinnerViewController = SpinnerViewController()
    
    struct Actions {
        
        var openMovie: (_ movieID: String) -> Void
    }
    
    var actions: Actions?
    
    convenience init(viewModel: WishlistViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        dataSource = MoiveListDataSource(viewModel: viewModel)
        delegate = MovieListDelegate(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTableView()
        loadWishlist()
    }
    
    // MARK: - Private
    
    private func setupTabBar() {
        tabBarController?.delegate = self
    }
    
    private func setupTableView() {    
        actions.do { actions in
            delegate?.actions = .init(openMovie: actions.openMovie)
        }
        
        MovieListStyle.baseMovieListStyle(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    private func loadWishlist() {
        viewModel?.onLoading = { isLoading in
            if isLoading {
                self.showSpinner()
            } else {
                self.hideSpinner()
            }
        }
        viewModel?.onDataLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
