import UIKit

class SearchMoviesViewController: UIViewController, RefreshableViewController {
  
  // MARK: Properties

  @IBOutlet weak var tableView: UITableView!
  private var dataSource: MoiveListDatsSource?
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
    dataSource = MoiveListDatsSource(viewModel: viewModel)
    delegate = MovieListDelegate(viewModel: viewModel)
  }
  
  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel?.searchDelegate = self
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
    
    tableView.separatorStyle = .none
    tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
    tableView.dataSource = dataSource
    tableView.delegate = delegate
    tableView.backgroundColor = Constants.Colors.clear
    tableView.rowHeight = Constants.Sizes.tableViewRowStandart
  }

  private func configureNavBar() {
    navigationItem.title = "Search Movies"
  }
  
  private func fetchMovies(by title: String) {
    showSpinner()
    viewModel?.fetchMovies(by: title)
  }

  private func configureSearchBar() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
    searchController.searchBar.delegate = self
  }
}

// MARK: - Extensions

extension SearchMoviesViewController: SearchDelegate {

  func reloadTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.hideSpinner()
      self?.tableView.reloadData()
    }
  }
}

extension SearchMoviesViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    fetchMovies(by: searchBar.text ?? "")
  }
}
