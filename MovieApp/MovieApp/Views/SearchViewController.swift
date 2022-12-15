import UIKit

class SearchViewController: UIViewController {
  
  // MARK: Properties
  
  private var viewModel: MovieViewModelProtocol = MovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
 // private var tableView = UITableView()

  @IBOutlet weak var tableView: UITableView!
  
  private var movies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchMovies(by: "pulp")
  }
  
  // MARK: Public
  
  // MARK: Private
  
  private func setUpTableView() {
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = movies[indexPath.row]
    cell.setUp(from: movie)
    return cell
  }
}

extension SearchViewController: ViewDelegate {
  func reloadTableView(with movies: [Movie]) {
    self.movies = movies
    tableView.reloadData()
  }
}
