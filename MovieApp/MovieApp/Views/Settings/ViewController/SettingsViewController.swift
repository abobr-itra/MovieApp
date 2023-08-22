import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: SettingsViewModelProtocol?
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true

        return imageView
    }()
    
    private let profileTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
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
        
        view.backgroundColor = tableView.backgroundColor
        setupTableView()
        setupProfile()
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        title = "Settings".localized()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: view.bounds.height)
    }
    
    private func setupProfile() {
        setupProfileImage()
        setupProfileLabel()
    }
    
    private func setupProfileImage() {
        profileImage.image = UIImage(named: "profile_placeholder")
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupProfileLabel() {
        profileTitle.text = "Andrey Bobr"
        view.addSubview(profileTitle)
        NSLayoutConstraint.activate([
            profileTitle.widthAnchor.constraint(equalToConstant: 100),
            profileTitle.heightAnchor.constraint(equalToConstant: 20),
            profileTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 110),
            profileTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - Extensions

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sectionTitle(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sectionsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.optionsCount(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let option = viewModel?.option(at: indexPath.row, section: indexPath.section),
              let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier,
                                                       for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.option(at: indexPath.row, section: indexPath.section).handler()
    }
}
