import UIKit
import Combine

class SearchMoviesViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MoiveListDataSource?
    private var delegate: MovieListDelegate?
    
    private var viewModel: SearchMovieViewModelProtocol?
    private var subscriptions: Set<AnyCancellable> = []
    private let searchController = UISearchController(searchResultsController: nil)
    var spinner: SpinnerViewController = SpinnerViewController()

    convenience init(viewModel: SearchMovieViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        dataSource = MoiveListDataSource(viewModel: viewModel)
        delegate = MovieListDelegate(viewModel: viewModel)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureNavBar()
        setupTableView()
        setupViewModel()
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        MovieListStyle.baseMovieListStyle(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

    private func configureNavBar() {
        let localizedTitle = "Search Movies".localized()
        navigationItem.title = localizedTitle
    }
    
    private func setupViewModel() {
        viewModel?.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.showSpinner(isLoading)
            }
            .store(in: &subscriptions)

        viewModel?.isDataLoadedPublisher
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] isLoaded in
                if isLoaded {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        bind()
    }
    
    private func bind() {
        searchController.searchBar.searchTextField.textPublisher
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] movieTitle in
                self?.viewModel?.movieTitle = movieTitle
            })
            .store(in: &subscriptions)
    }
}
