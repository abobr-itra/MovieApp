import UIKit

class SettingsViewController: UIViewController {
  
  // MARK: - Properties
  
  private var viewModel: SettingsViewModelProtocol?
  
  private let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.register(SettingsCell.self,
                   forCellReuseIdentifier: SettingsCell.identifier)
    
    return table
  }()
  
  convenience init(viewModel: SettingsViewModelProtocol) {
    self.init(nibName: nil, bundle: nil)
    
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  // MARK: - Private
  
  private func setupTableView() {
    title = "Settings"
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.frame = view.bounds
  }
}

// MARK: - Extensions

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.optionsCount() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let option = viewModel?.option(at: indexPath.row),
          let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier,
                                                   for: indexPath) as? SettingsCell else {
      return UITableViewCell()
    }

    cell.setup(with: option)
    return cell
  }
}
