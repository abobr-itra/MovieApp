import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: SettingsViewModelProtocol?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
        
    private let scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private var headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 0.5
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 40
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
        table.layer.cornerRadius = 10
        return table
    }()
    
    convenience init(viewModel: SettingsViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = tableView.backgroundColor
        setupScrollView()
    }
    
    // MARK: - Private
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = tableView.backgroundColor
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        setupStackView()
    }
    
    private func setupStackView() {
        scrollView.addSubview(scrollViewContainer)
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.bottomAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        setupHeaderContainer()
        setupTableView()
    }

    private func setupTableView() {
        title = "Settings".localized()
        scrollViewContainer.addArrangedSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileTitle.topAnchor, constant: 25),
            tableView.widthAnchor.constraint(equalTo: scrollViewContainer.widthAnchor),
        ])
    }
    
    private func setupHeaderContainer() {
        scrollViewContainer.addArrangedSubview(headerContainer)
     //   headerContainer.backgroundColor = .red
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: scrollViewContainer.topAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 200),
            headerContainer.widthAnchor.constraint(equalTo: scrollViewContainer.widthAnchor, multiplier: 1.0)
        ])
        setupProfile()
    }
    
    private func setupProfile() {
        setupProfileImage()
        setupProfileLabel()
    }
    
    private func setupProfileImage() {
        headerContainer.addSubview(profileImage)
        profileImage.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            profileImage.topAnchor.constraint(equalTo: headerContainer.layoutMarginsGuide.topAnchor, constant: 15),
            profileImage.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
        ])
    }

    private func setupProfileLabel() {
        profileTitle.text = "Jhone Doe"
        headerContainer.addSubview(profileTitle)
        NSLayoutConstraint.activate([
            profileTitle.widthAnchor.constraint(equalToConstant: 100),
            profileTitle.heightAnchor.constraint(equalToConstant: 25),
            profileTitle.topAnchor.constraint(equalTo: profileImage.layoutMarginsGuide.bottomAnchor, constant: 25),
            profileTitle.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor)
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
