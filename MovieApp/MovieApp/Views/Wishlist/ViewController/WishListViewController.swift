import UIKit
import Combine

class WishListViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MoiveListDataSource?
    private var delegate: MovieListDelegate?
    
    private var subscriptions: Set<AnyCancellable> = []
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
        setupViewModel()
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
    
    private func setupViewModel() {
        guard let viewModel = viewModel as? WishlistViewModel else { return }
        
        viewModel.$isDataLoaded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoaded in
                if isLoaded {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.showSpinner()
                } else {
                    self?.hideSpinner()
                }
            }
            .store(in: &subscriptions)
    }
}

extension WishListViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        DispatchQueue.main.async {
            self.viewModel?.loadWishlist()
        }
    }
}
