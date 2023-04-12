import UIKit

class SearchMoviesViewController: UIViewController {
  
  // MARK: IBOutlets
  
 // @IBOutlet weak var tableView: UITableView? // TODO: Move IBOutlet and all UI to separate view, create config file for view
  
  
  @IBOutlet private weak var tableView: UITableView?
  
  // MARK: Properties

  private var viewModel: SearchMovieViewModelProtocol?
  private let searchController = UISearchController(searchResultsController: nil) // TODO: Move to separate view
  
  struct Data {
//    var moviesCount: () -> Int
//    var movieAtIndex: (_ index: Int) -> Movie
  }
  
  struct Actions {
    var openMovie: (_ movieID: String) -> Void
  }
  
  var data: Data?
  var actions: Actions?
  
  convenience init(viewModel: SearchMovieViewModelProtocol) {
    self.init(nibName: nil, bundle: nil)
    print("♦️SearchMovieViewController init viewModel:", viewModel)
    self.viewModel = viewModel
  }
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    self.viewModel?.searchDelegate = self
    configureSearchBar()
    configureNavBar()
    setUpTableView()
    print("♦️SearchMovieViewController viewDidLoad viewModel: \(viewModel)")
    fetchMovies(by: "Pulp Fiction")
  }

  // MARK: Private
  
  private func configureNavBar() {
    navigationItem.title = "Search Movies"
  }
  
  private func fetchMovies(by title: String) {
    viewModel?.fetchMovies(by: title)
  }

  private func setUpTableView() {
    guard let tableView = tableView else { return }
    view.addSubview(tableView)
    tableView.backgroundColor = Constants.Colors.clear
    tableView.rowHeight = Constants.Sizes.tableViewRowStandart
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
  }
  
  private func configureSearchBar() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
    searchController.searchBar.delegate = self
  }
}

// MARK: Extensions

extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("♦️SearchMovieViewController tableView count viewModel: \(viewModel)")
    return viewModel?.moviesCount() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = viewModel?.movie(at: indexPath.row)
    print("🤡 \(movie)")
    cell.setUp(from: movie)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = viewModel?.movie(at: indexPath.row)
    self.actions?.openMovie(movie?.imdbID ?? "")
  }
}

extension SearchMoviesViewController: SearchDelegate {
  func reloadTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView?.reloadData()
    }
  }
}

extension SearchMoviesViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    fetchMovies(by: searchBar.text ?? "")
  }
}
