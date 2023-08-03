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
        delegate = MovieListDelegate(viewModel: viewModel, deletePermited: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel?.loadWishlist()
    }
    
    // MARK: - Private
    
    private func setupTableView() {            
        MovieListStyle.baseMovieListStyle(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    private func setupViewModel() {
        viewModel?.isDataLoadedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoaded in
                if isLoaded {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        viewModel?.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.showSpinner(isLoading)
            }
            .store(in: &subscriptions)
    }
}
