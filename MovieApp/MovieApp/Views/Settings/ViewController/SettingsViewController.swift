import UIKit

class SettingsViewController: UIViewController {
  
  private var viewModel: SettingsViewModelProtocol?
  
  private let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.register(UITableViewCell.self,
                   forCellReuseIdentifier: "cell")
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                             for: indexPath)
    let option = viewModel?.option(at: indexPath.row)
    cell.textLabel?.text = option?.title
    return cell
  }
}
