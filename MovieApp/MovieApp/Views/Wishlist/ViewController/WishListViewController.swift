import UIKit

class WishListViewController: UIViewController {
  
  // MARK: IBOutlets
  
  @IBOutlet private weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
}

extension WishlistCoordinator: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
//      return UITableViewCell()
//    }
//    let movie = viewModel?.movie(at: indexPath.row)
//    print("🤡", movie)
//    cell.setUp(from: movie)
//    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let movie = viewModel?.movie(at: indexPath.row)
//    self.actions?.openMovie(movie?.imdbID ?? "")
  }
}
