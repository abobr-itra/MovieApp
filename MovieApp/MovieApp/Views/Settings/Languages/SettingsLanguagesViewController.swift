import UIKit

class SettingsLanguagesViewController: UIViewController {
    
    struct Data {
        
        var languages: [Language]
        var currentLanguage: Language
    }
    
    struct Actions {
        
        var select: (Language, @escaping (Result<Void, Error>) -> Void) -> Void
    }
    
    var data: Data?
    var actions: Actions?
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsLanguageCell.self,
                       forCellReuseIdentifier: SettingsLanguageCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        title = "Language".localized()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}

extension SettingsLanguagesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.languages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsLanguageCell.identifier,
                                                       for: indexPath) as? SettingsLanguageCell,
              let data = data else {
            return UITableViewCell()
        }
        let language = data.languages[indexPath.row]
        cell.configure(title: language.localName, subtitle: "language")
        cell.updateSemanticContentAttribute(localization: data.currentLanguage.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = data else { return }
        let language = data.languages[indexPath.row]
        actions?.select(language) { _ in
            tableView.reloadData()
        }
    }
}
