import UIKit

class SearchMoviesViewController: UIViewController, RefreshableViewControllerProtocol {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MoiveListDataSource?
    private var delegate: MovieListDelegate?
    
    private var viewModel: SearchMovieViewModelProtocol?
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
        fetchMovies(by: "Pulp Fiction")
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
    
    private func fetchMovies(by title: String) {
        viewModel?.onLoading = { [weak self] isLoading in
            if isLoading {
                self?.showSpinner()
            } else {
                self?.hideSpinner()
            }
        }
        
        viewModel?.onDataLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel?.fetchMovies(by: title)
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
}

// MARK: - Extensions

extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMovies(by: searchBar.text ?? "")
    }
}
