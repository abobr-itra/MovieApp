import UIKit

class MoiveListDatsSource: NSObject, UITableViewDataSource {
  
  private var viewModel: MovieViewModelProtocol
  
  init(viewModel: MovieViewModelProtocol) {
    self.viewModel = viewModel
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.moviesCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = viewModel.movie(at: indexPath.row)
    cell.setUp(from: movie)
    let backgroundView = UIView()
    backgroundView.layer.shadowOffset = cell.contentView.layer.shadowOffset
    backgroundView.backgroundColor = .systemGray
    cell.selectedBackgroundView = backgroundView
    return cell
  }
}

class MovieListDelegate: NSObject, UITableViewDelegate {
  
  struct Actions {

    var openMovie: (_ movieID: String) -> Void
  }

  var actions: Actions?
  private var viewModel: MovieViewModelProtocol
  
  init(viewModel: MovieViewModelProtocol) {
    self.viewModel = viewModel
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movie = viewModel.movie(at: indexPath.row)
    actions?.openMovie(movie.imdbID)
  }
}
