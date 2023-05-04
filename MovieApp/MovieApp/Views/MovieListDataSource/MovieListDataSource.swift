import UIKit

class MoiveListDatsSource: NSObject, UITableViewDataSource {
  
  private var viewModel: MovieViewModelProtocol
  
  init(viewModel: MovieViewModelProtocol) {
    self.viewModel = viewModel
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.moviesCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
      return UITableViewCell()
    }
    let movie = viewModel.movie(at: indexPath.row)
    cell.setUp(from: movie)
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
    print("✅ \(movie)")
    self.actions?.openMovie(movie.imdbID)
  }
}
