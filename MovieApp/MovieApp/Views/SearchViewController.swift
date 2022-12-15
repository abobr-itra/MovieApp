import UIKit

class SearchViewController: UIViewController {
  
  // MARK: Properties
  
  private var viewModel: MovieViewModelProtocol = MovieViewModel(movieService: MovieService(networkService: NetworkService(parser: NetworkParser())))
 // private var tableView = UITableView()

  @IBOutlet weak var tableView: UITableView!
  
  private var movies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    viewModel.delegate = self
    fetchMovies(by: "Pulp")
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
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("Movies count :", movies.count)
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Start reloading table 🤡")
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      print("Opps 🤡")
      return UITableViewCell()
    }
    let movie = movies[indexPath.row]
    cell.setUp(from: movie)
    return cell
  }
}

extension SearchViewController: ViewDelegate {
  func reloadTableView(with movies: [Movie]) {
    print("Start reloading table", self)
    DispatchQueue.main.async {
      self.movies = movies
      print(self.movies)
      self.tableView.reloadData()
    }
  }
}
