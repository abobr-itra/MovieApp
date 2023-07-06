import UIKit

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
