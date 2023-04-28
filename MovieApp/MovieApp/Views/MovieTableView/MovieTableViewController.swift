import UIKit

class MovieTableViewController: UITableViewController {
  
  private var viewModel: MovieViewModelProtocol?
  
  convenience init(viewModel: MovieViewModelProtocol?, tableView: UITableView?) {
    self.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
    self.tableView = tableView
  }
  
  struct Actions {

    var openMovie: (_ movieID: String) -> Void
  }
  
  var actions: Actions?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.backgroundColor = .red
    setup()
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.moviesCount() ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = viewModel?.movie(at: indexPath.row)
    print("🤡 \(String(describing: movie))")
    cell.setUp(from: movie)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = viewModel?.movie(at: indexPath.row)
    self.actions?.openMovie(movie?.imdbID ?? "")
  }
  
  // MARK: - Private
  
  private func setup() {
    tableView.backgroundColor = Constants.Colors.clear
    tableView.rowHeight = Constants.Sizes.tableViewRowStandart
    tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
  }
  
}
