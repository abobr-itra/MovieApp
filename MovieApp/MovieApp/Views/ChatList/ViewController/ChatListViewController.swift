import UIKit

class ChatListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var chatListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatListCell.self,
                           forCellReuseIdentifier: ChatListCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var navTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = LocalConstants.navTitleColor
        label.font = Constants.Fonts.plusJakartMediumLarge
        label.text = "Recent Chats"
        return label
    }()
    
    private var createButton: CreateChatButton = {
        let button = CreateChatButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private enum LocalConstants {
        
        static let navTitleColor = UIColor(red: 0.106, green: 0.102, blue: 0.342, alpha: 1)
        static let searchButtonColor = UIColor(red: 0.31, green: 0.37, blue: 0.48, alpha: 1)
        
        static let createButtonTrailingConstant: CGFloat = -24
        static let createButtonBottomConstant: CGFloat = -118
    }

    // MARK: - Properties
    
    private var viewModel: ChatListViewModelProtocol?
    
    // MARK: - Init
    
    convenience init(viewModel: ChatListViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        setupNavBar()
        setupTableView()
        setupCreateButton()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navTitleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "chat_search"),
                                                             style: .plain,
                                                             target: self,
                                                             action: nil)
        navigationItem.rightBarButtonItem?.tintColor = LocalConstants.searchButtonColor
    }
    
    private func setupTableView() {
        view.addSubview(chatListTableView)
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.frame = view.bounds
    }
    
    private func setupCreateButton() {
        view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LocalConstants.createButtonTrailingConstant),
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: LocalConstants.createButtonBottomConstant)
        ])
    }
}

extension ChatListViewController: UITableViewDelegate {
    
}

extension ChatListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.chats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatModel = viewModel?.chats[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: ChatListCell.identifier, for: indexPath) as? ChatListCell else {
            return UITableViewCell()
        }
        cell.setup(from: chatModel)
        return cell
    }
}
