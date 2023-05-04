import UIKit

protocol RefreshableViewController: UIViewController  {
  
  var spinner: SpinnerViewController { get set }
  func showSpinner()
  func hideSpinner()
}

extension RefreshableViewController {
  
  func showSpinner() {
    addChild(spinner)
    spinner.view.frame = view.frame
    view.addSubview(spinner.view)
    spinner.didMove(toParent: self)
  }
  
  func hideSpinner() {
    spinner.willMove(toParent: nil)
    spinner.view.removeFromSuperview()
    spinner.removeFromParent()
  }
}

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
    print("♦️SearchMovieViewController init viewModel:", viewModel)
    self.viewModel = viewModel
    dataSource = MoiveListDatsSource(viewModel: viewModel)
    delegate = MovieListDelegate(viewModel: viewModel)
    if let openMovie = actions?.openMovie {
      delegate?.actions = .init(openMovie: openMovie)
    }
  }
  
  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    viewModel?.searchDelegate = self
    configureSearchBar()
    configureNavBar()
    setupTableView()
    print("♦️SearchMovieViewController viewDidLoad viewModel: \(String(describing: viewModel))")
    fetchMovies(by: "Pulp Fiction")
  }

  // MARK: - Private

  private func setupTableView() {
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
