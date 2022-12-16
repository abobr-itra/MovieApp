import UIKit

class SearchViewController: UIViewController {
  
  // MARK: Properties
  
  private var viewModel: MovieViewModelProtocol = MovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
  private let searchController = UISearchController(searchResultsController: nil)
  
  @IBOutlet private weak var tableView: UITableView!
 
  private var movies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    viewModel.searchDelegate = self
    fetchMovies(by: "Pulp Fiction")
    configureSearchBar()
    configureNavBar()
  }
  
  // MARK: Public
  
  // MARK: Private
  
  private func configureNavBar() {
    navigationItem.title = "Search Movies"
  }
  
  private func fetchMovies(by title: String) {
    viewModel.fetchMovies(by: title)
  }
  
  private func setUpTableView() {
    view.addSubview(tableView)
    tableView.rowHeight = 80
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
    viewController.movieID = movie.imdbID
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension SearchViewController: SearchDelegate {
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
