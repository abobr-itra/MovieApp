import UIKit

class SearchViewController: UIViewController {
  
  // MARK: Properties
  
  private var viewModel: MovieViewModelProtocol = MovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
  private let searchController = UISearchController(searchResultsController: nil)
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  private var movies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    viewModel.delegate = self
    fetchMovies(by: "Pulp")
    configureSearchBar()
  }
  
  // MARK: Public
  
  // MARK: Private
  
  private func fetchMovies(by title: String) {
    viewModel.fetchMovies(by: title)
  }
  
  private func setUpTableView() {
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
  }
  
  func configureSearchBar() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
    searchController.searchBar.delegate = self
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = movies[indexPath.row]
    cell.setUp(from: movie)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = movies[indexPath.row]
    let viewController = MoviePageViewController()
    viewController.movie = movie
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension SearchViewController: ViewDelegate {
  func reloadTableView(with movies: [Movie]) {
    DispatchQueue.main.async {
      self.movies = movies
      self.tableView.reloadData()
    }
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    fetchMovies(by: searchBar.text ?? "")
  }
}
