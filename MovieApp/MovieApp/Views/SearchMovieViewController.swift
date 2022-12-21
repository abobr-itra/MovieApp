import UIKit

class SearchMovieViewController: UIViewController {

  // TODO: Use events, create coordinator
  
  
  // MARK: IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Properties
  // FIXME: Create viewmodel in coordinatior (convinience init)
  private var viewModel: SearchMovieViewModelProtocol = SearchMovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
  
  var coordinator: SearchMovieFlow?
 // private let searchController = UISearchController(searchResultsController: nil)
  // FIXME: Remove movies from VC, it should not contain this data at all
  private var movies: [Movie] = []
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpTableView()
    viewModel.searchDelegate = self
    fetchMovies(by: "Pulp Fiction")
   // configureSearchBar()
   // configureNavBar()
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
    tableView.backgroundColor = .clear
    tableView.rowHeight = 80
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
  }
  
//  private func configureSearchBar() {
//    navigationItem.searchController = searchController
//    navigationItem.hidesSearchBarWhenScrolling = true
//    searchController.searchBar.delegate = self
//  }
}

extension SearchMovieViewController: UITableViewDelegate, UITableViewDataSource {
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
    coordinator?.coordinateToMoviePage(by: movie.imdbID)
  }
}

extension SearchMovieViewController: SearchDelegate {
  func reloadTableView(with movies: [Movie]) {
    DispatchQueue.main.async {
      self.movies = movies
      self.tableView.reloadData()
    }
  }
}

//extension SearchMovieViewController: UISearchBarDelegate {
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    fetchMovies(by: searchBar.text ?? "")
//  }
//}
