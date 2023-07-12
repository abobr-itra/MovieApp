import UIKit
import Combine

class SearchMoviesViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MoiveListDataSource?
    private var delegate: MovieListDelegate?
    
    private var viewModel: SearchMovieViewModelProtocol?
    private var subscriptions = Set<AnyCancellable>()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.viewDidAppear()
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
            .sink { isLoading in
                DispatchQueue.main.async { [weak self] in
                    if isLoading {
                        self?.showSpinner()
                    } else {
                        self?.hideSpinner()
                    }
                }
            }
            .store(in: &subscriptions)

        viewModel.$isDataLoaded
            .sink{ isLoaded in
                if isLoaded {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
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
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification,
                                                             object: searchController.searchBar.searchTextField)
      //  viewModel?.bindMovieTitle(publisher: publisher)
        publisher
            .compactMap { ($0.object as? UISearchTextField)?.text }
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { movieTitle in
                print("MovieTitle: \(movieTitle)")
                self.viewModel?.movieTitle = movieTitle
                self.viewModel?.searchMovies(by: movieTitle)
            }
            .store(in: &subscriptions)
    }
}
