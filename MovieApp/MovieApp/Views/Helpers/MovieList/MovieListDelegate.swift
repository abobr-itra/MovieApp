import UIKit

class MovieListDelegate: NSObject, UITableViewDelegate {

    private var deletePermited: Bool
    private var viewModel: MovieViewModelProtocol
    
    init(viewModel: MovieViewModelProtocol, deletePermited: Bool = false) {
        self.viewModel = viewModel
        self.deletePermited = deletePermited
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        viewModel.openMovie(movie.imdbID)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completionHandler in
            self?.viewModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: deletePermited ? [delete] : [])
    }
}
