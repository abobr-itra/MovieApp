import UIKit
import Foundation

class MoviesTableView: UITableView {
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    self.separatorStyle = .none
    self.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                       forCellReuseIdentifier: MovieCell.identifier)
    self.backgroundColor = Constants.Colors.clear
    self.rowHeight = Constants.Sizes.tableViewRowStandart
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
