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
    
    struct Actions {
        
        var openMovie: (_ movieID: String) -> Void
    }
    
    var actions: Actions?
    
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
        actions.do { actions in
            delegate?.actions = .init(openMovie: actions.openMovie)
        }
        MovieListStyle.baseMovieListStyle(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

    private func configureNavBar() {
        let localizedTitle = "Search Movies".localized()
        navigationItem.title = localizedTitle
    }
    
    private func setupViewModel() {
        guard let viewModel = viewModel as? SearchMovieViewModel else { // FIXME: Solution to use @Publised properties
            return
        }
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

        viewModel.$isDataLoaded
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
        guard let viewModel = viewModel as? SearchMovieViewModel else { return }
        searchController.searchBar.searchTextField.textPublisher
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .assign(to: \.movieTitle, on: viewModel)
            .store(in: &subscriptions)
    }
}
