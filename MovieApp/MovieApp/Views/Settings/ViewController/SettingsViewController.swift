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
    
    struct Constants {

        static fileprivate let headerHeight: CGFloat = 150
    }
    
    private var headerTopConstraint: NSLayoutConstraint!
    private var headerHeightConstraint: NSLayoutConstraint!

    private var headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private var profileImageCenterConstraint: NSLayoutConstraint!
    private var profileImageTopConstraint: NSLayoutConstraint!
    
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
    
    private var profileTitleTopConstraint: NSLayoutConstraint!
    
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
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 10
        table.bounces = false
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
            tableView.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 25),
            tableView.widthAnchor.constraint(equalTo: scrollViewContainer.widthAnchor),
        ])
    }
    
    private func setupHeaderContainer() {
        scrollViewContainer.addArrangedSubview(headerContainer)
        headerTopConstraint = headerContainer.topAnchor.constraint(equalTo: scrollViewContainer.layoutMarginsGuide.topAnchor)
        headerHeightConstraint = headerContainer.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        NSLayoutConstraint.activate([
            headerTopConstraint,
            headerHeightConstraint,
            headerContainer.trailingAnchor.constraint(equalTo: scrollViewContainer.layoutMarginsGuide.trailingAnchor),
            headerContainer.widthAnchor.constraint(equalTo: scrollViewContainer.layoutMarginsGuide.widthAnchor, multiplier: 1.0)
        ])
        setupProfile()
    }
    
    private func setupProfile() {
        setupProfileImage()
        setupProfileLabel()
    }
    
    private func setupProfileImage() {
        headerContainer.addSubview(profileImage)
        profileImageCenterConstraint = profileImage.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor)
        profileImageTopConstraint = profileImage.topAnchor.constraint(equalTo: headerContainer.layoutMarginsGuide.topAnchor, constant: 15)
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            profileImageTopConstraint,
            profileImageCenterConstraint,
        ])
    }

    private func setupProfileLabel() {
        profileTitle.text = "Jhone Doe"
        headerContainer.addSubview(profileTitle)
        profileTitleTopConstraint = profileTitle.topAnchor.constraint(equalTo: profileImage.layoutMarginsGuide.bottomAnchor, constant: 25)
        NSLayoutConstraint.activate([
            profileTitle.widthAnchor.constraint(equalToConstant: 175),
            profileTitle.heightAnchor.constraint(equalToConstant: 30),
            profileTitleTopConstraint,
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

extension SettingsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            // Scrolling down: Scale
            headerHeightConstraint?.constant =
                Constants.headerHeight - scrollView.contentOffset.y
        } else {
            // Scrolling up: Parallax
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant =
                Constants.headerHeight - scrollView.contentOffset.y
            profileImageCenterConstraint.constant = -availableOffset * 15
            profileImageTopConstraint.constant = 15 - availableOffset * 2.5
            profileTitleTopConstraint.constant = 25 - availableOffset * 7
        }
    }
}
