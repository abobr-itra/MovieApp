import UIKit

class MovieListStyle {
    
    public static func baseMovieListStyle(_ tableView: UITableView) {
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.Colors.clear
        tableView.rowHeight = Constants.Sizes.tableViewRowStandart
    }
}
