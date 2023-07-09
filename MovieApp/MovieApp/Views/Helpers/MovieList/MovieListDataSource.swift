import UIKit

class MoiveListDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel: MovieViewModelProtocol
    
    init(viewModel: MovieViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
            return UITableViewCell()
        }
        let movie = viewModel.movie(at: indexPath.row)
        cell.setUp(with: movie)
        return cell
    }
}
