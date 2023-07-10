import UIKit

class ApperanceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let themeSwitch = UISwitch()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "ApperanceCell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSwitch()
        setupTableView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        title = "Settings".localized()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    private func setupSwitch() {
        let isDarkThemeOn = UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .dark
        themeSwitch.setOn(isDarkThemeOn, animated: false)
        themeSwitch.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
    }
    
    @objc
    func switchValueDidChange(_ sender: UISwitch) {
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }
}

extension ApperanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "ApperanceCell")
        var content = cell.defaultContentConfiguration()
        content.text = "Dark Apperance"
        cell.contentConfiguration = content
        cell.accessoryView = themeSwitch
        return cell
    }
}
